## Technical Debt
- [ ] Subnets should be created via some type of iterator not just this endless "subnet_1", "subnet_2" nonsense.
- [ ] Do something about this ridiculous copy/paste repetition I keep seeing at these various levels.
- [ ] Investigate `locals` and flat structure as a means of addresing the previous point about repeated chunks of code.
-  [ ] Update logs to not reference caller identity but be passed in as a variable.
- [ ] Encrypt cloudwatch log data.
- [ ] Find a better way than just copy/pasting out the modules you do not want to deploy...
- [ ] Investigate kitchen sink style exports/more complex export types from a module + the rammifications/implementation details of how the values are actually exposed, i.e. would I have to load a chonker into memory just to pick off one value? 
- [ ] Investigate encryption context restrictions for kms_grants
- [ ] Correct for naive single account implementation references.