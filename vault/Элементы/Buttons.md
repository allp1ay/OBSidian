```button
name 🔊
type command
class button-as-link
action Audio Player: Resume Audio
```
^button-play-music

```button
name 🔈
type command
class button-as-link
action Audio Player: Pause Audio
```
^button-pause-music

```button
name To the Forum Batman!
type link
action obsidian://open?vault=OBSidian&file=1.%20%D0%9D%D0%B0%D1%87%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9%20%D0%AD%D0%BA%D1%80%D0%B0%D0%BD%2F1.%20%D0%9D%D0%B0%D1%87%D0%B0%D0%BB%D1%8C%D0%BD%D1%8B%D0%B9%20%D0%AD%D0%BA%D1%80%D0%B0%D0%BD
```
^button-start

```button
name ⏯️
swap [pause-music, play-music]
```
^button-swap

`button-swap`


```php-template
<video src="file:///C:%5CMax.mov%5COBSidian%5CAssets%5CMedia%5CHow%20Could%20This%20Be%20Wrong%20(feat.%20Tula)%20(Jaz%20remix).mp3" controls autoplay loop></video>
```

---

```button
name 🔊
type command
class button-as-link
action Audio Player: Start Audio
```
^button-play

```button
name 🔈
type command
class button-as-link
action Audio Player: Stop Audio
```
^button-stop

```button
name Музыка
swap [stop, play]
class button-swaps
```
^button-swaps

```button
name Начать Установку
type command
class button-as-link
action Better Command Palette: Start OBS Guide
```
^button-guide

---

```button
name Начать Установку
type command
class button-guide
action Better Command Palette: Start OBS Guide
```
^button-guide