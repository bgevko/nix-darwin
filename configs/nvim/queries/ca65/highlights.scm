; ca65 assembly highlighting

(comment) @comment

(string) @string
(char) @character

(number) @number
(base) @number

(label) @label

(mnemonic) @keyword

(preproccmd) @keyword.directive
(procstart) @keyword.directive
(procend) @keyword.directive
(macrostart) @keyword.directive
(macroend) @keyword.directive

(register) @variable.builtin

(equ
  constant: (identifier) @constant)

(proc
  proc_name: (identifier) @function)

(macro
  (identifier) @function.macro)

(identifier) @variable

(operator) @operator
(equal) @operator

(valuetag) @punctuation.special
(separator) @punctuation.delimiter
(bracket) @punctuation.bracket
