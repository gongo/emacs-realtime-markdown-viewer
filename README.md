# Emacs Realtime Markdown Viewer

Emacs Realtime Markdown Viewer with websocket.el and Amon2.


## Requirements
* Emacs 23 or higher. (version 24 is better than version 23)
* Latest [websocket.el](https://github.com/ahyatt/emacs-websocket)
    - websocket.el older than 2012/SEP/01 does not support multibyte characters
* [Amon2](https://github.com/tokuhirom/Amon) 3.5 or higher
* [Amon2::Lite](https://github.com/tokuhirom/Amon2-Lite)


## Demonstration
* [youtube](http://www.youtube.com/watch?feature=player_embedded&v=qnoMo0ynyZo)


## How to Run

### Select language
You can select WebApp implementation, Perl(Amon2) or Ruby(Sinatra).
Default is Perl, because I'm beginner of Ruby programming.

```` elisp
;; Use Sinatra App
(setq rtmv:lang 'ruby)
````

### Perl Dependency Setting

````
% cpanm Amon2 Amon2::Lite Protocol::WebSocket Twiggy
````

### Ruby Setting

````
% bundle install --path=vender/bundler
````

### Client
Run WebApp and connect to Web application

    M-x realtime-markdown-viewer-mode


### Browser
Access to http://0.0.0.0:5021/


Limitation
----------
* There are some bugs.
