# ABAP New Syntax Demos

## Overview

This repository demonstrates modern ABAP programming techniques using the **new ABAP syntax (7.40+)**.
The focus is on writing clean, concise, and expressive code aligned with current SAP development standards.

---

## Features

* Inline declarations (`DATA(...)`)
* Expressions (`VALUE`, `COND`, `SWITCH`)
* Table operations (`FOR`, `FILTER`, `REDUCE`)
* String templates
* Open SQL enhancements
* Internal table processing using modern syntax

---

## Examples Included

### Inline Declarations

```abap
DATA(lv_text) = 'Hello ABAP'.
```

### VALUE Operator

```abap
DATA(lt_numbers) = VALUE #( ( 1 ) ( 2 ) ( 3 ) ).
```

### FOR Expression

```abap
DATA(lt_result) = VALUE #( FOR i = 1 UNTIL i > 10 ( i ) ).
```

### REDUCE

```abap
DATA(lv_sum) = REDUCE i( INIT x = 0 FOR wa IN lt_numbers NEXT x = x + wa ).
```

---

## Technologies

* ABAP 7.40+
* Open SQL
* Internal Tables

---

## Purpose

This project demonstrates the transition from classical ABAP to modern, expression-based programming.
It is intended for developers who want to write more efficient and readable ABAP code.

---

## System

Developed in SAP NetWeaver AS ABAP 7.52 Developer Edition.

---

## Author

Yassine

