# CWD3 dynamic data visualization platform for insights and support of the crystallographic software

CrystalWalk is a web-based 3D interactive crystal editor and visualization software designed for teaching materials science and engineering aiming to provide an easy to use and accessible platform to students, professors and researchers. Additional project information is available at its official page http://gvcm.ipen.br/CrystalWalk, including contributors and team members, documentation, research premises, step-by-step guides and videos as well reaching the authors regarding any questions, comments, or concerns.


Software architecture is composed by the 3 specific applications CWAPP, CWLY, CW4P. 

CWAPP: is CrystalWalk's main application component based in HTML5/WebGL.

CWLY: is the URL Shortener and persistence API

CW4P: design pattern that implements event-oriented paradigm for WebGL technology, foundation of the main CrystalWalk application (CWAPP)


Additionally, CWD3 is a dynamic data visualization platform built using D3 to gather insights and support the systematic review analysis of the crystallographic software.

CrystalWalk is open-source licensed under the MIT license.

## Development

Install Node.js:

```
https://nodejs.org
```

Clone project:

```
git clone git@github.com:gvcm/CWD3.git
```

```
cd CWD3
```

Install dependencies:

```
sudo npm install -g gulp
npm install
```

Run application:

```
gulp
```

## Production

### Deploying to Heroku

```
$ heroku create
$ git push heroku master
$ heroku open
```
