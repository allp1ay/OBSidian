-- toggle_ui.lua
obs = obslua
ffi = require("ffi")

-- WinAPI declarations
ffi.cdef[[
  typedef void* HWND;
  typedef unsigned long DWORD;
  typedef int BOOL;
  typedef BOOL (__stdcall *EnumWindowsProc)(HWND, void*);

  DWORD   GetCurrentProcessId(void);
  BOOL    EnumWindows(EnumWindowsProc lpEnumFunc, void* lParam);
  DWORD   GetWindowThreadProcessId(HWND hWnd, DWORD* lpdwProcessId);
  int     GetWindowTextLengthA(HWND hWnd);
  int     GetWindowTextA(HWND hWnd, char* lpString, int nMaxCount);
  BOOL    IsWindowVisible(HWND hWnd);
  BOOL    ShowWindow(HWND hWnd, int nCmdShow);
  BOOL    SetForegroundWindow(HWND hWnd);
  void    SwitchToThisWindow(HWND hWnd, BOOL fAltTab);
  void    Sleep(DWORD dwMilliseconds);
  HWND    FindWindowA(const char* lpClassName, const char* lpWindowName);
  BOOL    SetForegroundWindow(HWND hWnd);
]]

-- Show/Hide constants
local SW_SHOW       = 5
local SW_MINIMIZE   = 6
local SW_NORMAL = 1

-- Hotkey identifier
local hotkey_id = obs.OBS_INVALID_HOTKEY_ID

function script_description()
  return "Toggle OBS main window (show ↔️ hide) via WinAPI with delay for reliable focus"
end

function script_properties()
  return obs.obs_properties_create()
end

function script_load(settings)
  hotkey_id = obs.obs_hotkey_register_frontend(
    "toggle_obs_ui", "Toggle OBS UI", toggle_ui
  )
  local arr = obs.obs_data_get_array(settings, "toggle_obs_ui")
  obs.obs_hotkey_load(hotkey_id, arr)
  obs.obs_data_array_release(arr)
end

function script_save(settings)
  local arr = obs.obs_hotkey_save(hotkey_id)
  obs.obs_data_set_array(settings, "toggle_obs_ui", arr)
  obs.obs_data_array_release(arr)
end

-- Find OBS main window: first by Qt class, then by title enumeration
local function find_main_window()
  -- Try Qt5 window class first
  local h = ffi.C.FindWindowA("Qt5QWindowIcon", nil)
  if h ~= nil then
    return h
  end

  -- Fallback: enumerate all windows of this process
  local target = ffi.new("HWND[1]")
  local pid    = ffi.C.GetCurrentProcessId()
  local buf    = ffi.new("char[512]")
  local procId = ffi.new("DWORD[1]")

  local function enum_proc(hwnd, _)
    ffi.C.GetWindowThreadProcessId(hwnd, procId)
    if procId[0] == pid then
      local len = ffi.C.GetWindowTextLengthA(hwnd)
      if len > 0 and len < 512 then
        ffi.C.GetWindowTextA(hwnd, buf, 512)
        local title = ffi.string(buf)
        if title:find("OBS") then
          target[0] = hwnd
          return false  -- stop enumeration
        end
      end
    end
    return true  -- continue enumeration
  end

  local cb = ffi.cast("EnumWindowsProc", enum_proc)
  ffi.C.EnumWindows(cb, nil)
  cb:free()
  return target[0]
end

function open_window(recursive)
  local hWnd = find_main_window()
  if hWnd == nil then
    obs.script_log(obs.LOG_WARNING, "OBS window not found!")
    return
  end

  if ffi.C.IsWindowVisible(hWnd) == 1 then
    -- Window is visible: minimize to tray
    ffi.C.ShowWindow(hWnd, SW_MINIMIZE)
  else
    -- Window is hidden: show with slight delay before focusing
    ffi.C.ShowWindow(hWnd, SW_SHOW)
    ffi.C.SwitchToThisWindow(hWnd, true)

    -- ffi.C.Sleep(200)

    -- check if we already in recursion, so we don't call it again
    if not recursive then
      open_window(true)
    end
  end
end

-- Toggle logic: minimize or show with delay and focus
function toggle_ui(pressed)
  if not pressed then
    return
  end

  open_window(false)
end
