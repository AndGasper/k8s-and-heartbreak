## Angular 

- I must be getting old because npm doesn't work like it used to (or maybe webpack just spoiled me).

```
npx ng new k8s-and-heartbreak
```

- When did web pages stop being good old fashioned: 
    - html
    - css
    - js
    - some build tooling

```
npm WARN deprecated fsevents@1.2.9: One of your dependencies needs to upgrade to fsevents v2: 1) Proper nodejs v10+ support 2) No more fetching binaries from AWS, smaller package size
```

- >  But I'm losing my edge to better-looking people with better ideas and more talent.
And they're actually really, really nice.


- Kids these days. Never had to update a `$PATH` variable a day in their lives!
- [StackOverflow: Extend Path Variable in Git Bash Under Windows](https://stackoverflow.com/questions/45980107/extend-path-variable-in-git-bash-under-windows)

- ~I'll try the symlink suggestion just to be bougie~ Nope.
- [ln](https://linux.die.net/man/1/ln)
- (Insert I'm gonna pretend I didn't see that in terms of thinking about the implication of a relative reference...)
```
ln -s ./node_modules/\@angular/cli/bin/ng ng
```
- Remove symlink: `unlink ng`

- :triumph:
    - Just `npm run ng` or `npx ng` because this is turning into a rabbit hole. 

```
$ npx ng serve
i ｢wds｣: Project is running at http://localhost:4200/webpack-dev-server/
i ｢wds｣: webpack output is served from /
i ｢wds｣: 404s will fallback to //index.html

chunk {main} main.js, main.js.map (main) 48 kB [initial] [rendered]
chunk {polyfills} polyfills.js, polyfills.js.map (polyfills) 264 kB [initial] [rendered]
chunk {runtime} runtime.js, runtime.js.map (runtime) 6.15 kB [entry] [rendered]
chunk {styles} styles.js, styles.js.map (styles) 9.8 kB [initial] [rendered]
chunk {vendor} vendor.js, vendor.js.map (vendor) 3.81 MB [initial] [rendered]
Date: 2019-12-01T05:26:58.725Z - Hash: e62108aaf4e18913f517 - Time: 9981ms
** Angular Live Development Server is listening on localhost:4200, open your browser on http://localhost:4200/ **
i ｢wdm｣: Compiled successfully.
```