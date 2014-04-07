#lang racket

; Csound 6 FFI Interface
; Author: Steven Yi<stevenyi@gmail.com>

(provide csound-initialize csound-create csound-set-option 
         csound-compile csound-compile-orc csound-read-score
         csound-start csound-perform csound-perform-ksmps 
         csound-stop)
        
(require racket/system
         ffi/unsafe
         ffi/unsafe/define)

(define-ffi-definer define-csound (ffi-lib "libcsound64"))

(define _CSOUND-pointer (_cpointer 'CSOUND))


(define-csound csoundInitialize (_fun _int -> _void))
(define-csound csoundCreate (_fun -> _CSOUND-pointer))
(define-csound csoundSetOption (_fun _CSOUND-pointer _string -> _void))
(define-csound csoundCompileOrc (_fun _CSOUND-pointer _string -> _void))
(define-csound csoundReadScore (_fun _CSOUND-pointer _string -> _void))

(define-csound csoundCompile (_fun _CSOUND-pointer _int  (_array/list _string 2) -> _int))
(define-csound csoundStart (_fun _CSOUND-pointer -> _int))
(define-csound csoundPerform (_fun _CSOUND-pointer -> _int))
(define-csound csoundPerformKsmps (_fun _CSOUND-pointer -> _int))
(define-csound csoundStop (_fun _CSOUND-pointer -> _void))


(define (csound-initialize flags)
  (csoundInitialize flags))

(define csound-create csoundCreate)
(define csound-set-option csoundSetOption)

(define csound-compile-orc csoundCompileOrc)
(define csound-read-score csoundReadScore)
(define (csound-compile cs args)
  (csoundCompile cs (length args) args))

(define csound-start csoundStart)
(define csound-perform csoundPerform)
(define csound-perform-ksmps csoundPerformKsmps)
(define csound-stop csoundStop)