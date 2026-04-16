class ZCLASS_SUM definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !PVALUE type CHAR1 .
  methods SUM
    importing
      !PINPUT1 type NUMC2
      !PINPUT2 type NUMC2
    exporting
      !POUTPUT type NUMC3 .
protected section.
private section.
ENDCLASS.



CLASS ZCLASS_SUM IMPLEMENTATION.


  method CONSTRUCTOR.
  endmethod.


  method SUM.
    poutput = pinput1 + pinput2.
  endmethod.
ENDCLASS.
