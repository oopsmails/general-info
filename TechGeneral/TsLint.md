

## Other Tips of Using TSLint
How to suppress TSLint rules for the current file and even for the current line. 	
/* tslint:disable */ - Disable all rules for the rest of the file
/* tslint:enable */ - Enable all rules for the rest of the file
/* tslint:disable:rule1 rule2 rule3... */ - Disable the listed rules for the rest of the file
/* tslint:enable:rule1 rule2 rule3... */ - Enable the listed rules for the rest of the file
// tslint:disable-next-line - Disables all rules for the following line
someCode(); // tslint:disable-line - Disables all rules for the current line
// tslint:disable-next-line:rule1 rule2 rule3... - Disables the listed rules for the next line
More information:

https://palantir.github.io/tslint/usage/rule-flags/


Suppress with ts-ignore	
// @ts-ignore





