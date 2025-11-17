const { Plugin } = require('obsidian');

module.exports = class AutoCloseReleaseNotesPlugin extends Plugin {
  onload() {
    console.log("AutoCloseReleaseNotes загружен");

    this.registerEvent(
      this.app.workspace.on("active-leaf-change", (leaf) => {
        if (!leaf) return;
        const view = leaf.view;
        const name = view.getDisplayText?.() ?? "";

        if (name.toLowerCase().includes("release notes")) {
          leaf.detach();
          console.log("Закрываю вкладку Release Notes:", name);
        }
      })
    );
  }

  onunload() {
    console.log("AutoCloseReleaseNotes выгружен");
  }
};
