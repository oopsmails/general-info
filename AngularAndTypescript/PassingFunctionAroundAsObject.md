
# Passing Function Around as Object

## Notes:

### passed as callback

```
var myModal = ...;
var myObj = {
  name: "Close",
  callback: () => { myModal.close(); }
}

```

Now usage just looks like this, as there is no input params:

myObj.callback();

### similiar to above, 

Just like your buttons, you can pass your methods/callbacks to your service and then call them from within the service, e.g.

openConfirmModal() {
  this.service.openmodal({
    buttons: [ {name: 'Close'} ],
    methods: {
      onClose: () => {/** your function body goes here */},
      onSubmit: () => {/** your function body goes here*/}
      .
      .
      .
    }
  });
}
And then in your service, you can call them whenever you like.

### Make a array as MAP, to avoid big switch/ifelse

- in Model, declare object Type/Interface

```
interface ButtonLabelNav {
  abcType: string; // from AbcType, enum otherwise
  defType: string; // from DefType, enum otherwise
  buttonLabel: string;
  buttonFun: any
}
```

- in Component, declare the mapping

```
  BUTTON_LABEL_CLICKFUNCTION_MAP = [
    {
      'abcType': AbcType.AAA,
      'defType': DefType.DDD,
      'buttonLabel': 'KEY.AAA.DDD.IN.EN.FR.JSON.VIEW.DETAILS',
      'onClick': () => {this.showAaaDddDetails()}
    },
    {
      'abcType': AbcType.BBB,
      'defType': DefType.EEE,
      'buttonLabel': 'KEY.BBB.EEE.IN.EN.FR.JSON.VIEW.DETAILS',
      'onClick': () => {this.showBbbEeeDetails()}
    }
  ];

```

- in init(), or proper place to initialize Objects, as parameter to filter the MAP

Then filter/find on abcType and defType to determine label and onClick function. bigO, O(n)

BUTTON_LABEL_CLICKFUNCTION_MAP.find(item => AbcType[AbcType.AAA] === passedInAbcType && somestring === pasedInString);

- in html, do 

`(click)="onButtonClick()">`

- in Component, do

```
  onButtonClick() {
    this.buttonLabelNav.buttonFun(); // <------------------- key point is adding () after the field name to call as a Function!!!!!
  }
```


Note: 

- Typescript no Map key with object, just string and number
- Record is also not applicable in this case

### further improvements:

- DefType as Enum


export enum DefType {
  DDD = 'FundsWithdrawal',
  EEE = 'CreditCardApproachingLimit',
  FFF = 'CreditCardDeclinedTransaction',
  UNDEFINED = 'UNDEFINED'
}

- If need to pass parameters into the Function


- in Component, declare the mapping

```
  BUTTON_LABEL_CLICKFUNCTION_MAP = [
    {
      'abcType': AbcType.AAA,
      'defType': DefType.DDD,
      'buttonLabel': 'KEY.AAA.DDD.IN.EN.FR.JSON.VIEW.DETAILS',
      'onClick': (param1, param2) => {this.showAaaDddDetails(param1, param2)}
    },
    {
      'abcType': AbcType.BBB,
      'defType': DefType.EEE,
      'buttonLabel': 'KEY.BBB.EEE.IN.EN.FR.JSON.VIEW.DETAILS',
      'onClick': (param1, param2) => {this.showBbbEeeDetailsparam1, param2()}
    }
  ];

```

- in Component, do

```
  onButtonClick() {
    this.buttonLabelNav.buttonFun(this.param1, this.param2); // <------------------- key point is adding () after the field name to call as a Function!!!!!
  }
```






## Readings & References

### https://stackoverflow.com/questions/55779032/angular-pass-functions-to-service-inside-an-object/55791871





