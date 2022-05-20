#  Using hugo quick start

Run

```
npm install
```

to get tailwind etc.

Create new posts from this folder:

```
hugo new posts/2017/<blah>.md
```

Then include:

    +++
    type = "mathpost"
    +++

in the front matter to enable maths in that particular post.

Maths was added via [https://takuti.me/note/hugo-kramdown-and-katex/](https://takuti.me/note/hugo-kramdown-and-katex/)

Then:

    hugo serve -D --disableFastRender

to run up the dev server.

## Resizing images on mac

The following sets the max width or height to 128px:

    sips -Z 128 books.jpg

## Windows

Install [scoop](https://scoop.sh/) then:

```powershell
$ scoop install hugo-extended
```
