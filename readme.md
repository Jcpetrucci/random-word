# Random Hostname Generator 

This tool can be used to generate random hostnames.

When the script runs it reads in the wordlist.txt file and finds an unused random word. After outputting the random word, it marks it as 'used' by appending a comment of who used it and the date it was used.

Supply your own wordlist.  I recommend Oren Tirosh’s mnemonic encoding project.

### Perl Dependencies:

>*perl v5+*

>*date*

>*whoami*

>*file of words (wordlist.txt)*

#### Perl Usage:

```cli
./random-hostname.pl
```

##### Testing (for perl version)

```cli
perl random-hostname.test.pl
```

##### Expected test output:

```cli
Your random word is: <random word>
ok 1 - Should get the current user.
ok 2 - Should return current date/time.
ok 3 - Should return correct number of available words.
ok 4 - Should return an unused word.
ok 5 - Should return a random word
ok 6 - Should return correct location of word.
ok 7 - Should mark a word as used.
1..7
```
