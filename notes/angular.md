Because my npm does not seem to be wanting to alias things:
```
./node_modules/ng-cli/bin/ng.js --version
```

```
$ npm cache clean --force
npm WARN using --force I sure hope you know what you are doing.
```
- You and me both npm.
- That wasn't it.

- Looks like it is `npx` these days? 
- [npx](https://www.npmjs.com/package/npx)
    - I'll acquiesce and do a `npm install -g npx`
    ```
    By default, npx will check whether <command> exists in $PATH, or in the local project binaries, and execute that. If <command> is not found, it will be installed prior to execution.
    ```
    - Not quite.


## Angular
- [Getting Started with Angular: Your First App](https://angular.io/start)

- [Angular: File Structure](https://angular.io/guide/file-structure)