;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;
;;; tf-lispworks.lisp --- Lispworks implementation of trivial-features.
;;;
;;; Copyright (C) 2007, Luis Oliveira  <loliveira@common-lisp.net>
;;;
;;; Permission is hereby granted, free of charge, to any person
;;; obtaining a copy of this software and associated documentation
;;; files (the "Software"), to deal in the Software without
;;; restriction, including without limitation the rights to use, copy,
;;; modify, merge, publish, distribute, sublicense, and/or sell copies
;;; of the Software, and to permit persons to whom the Software is
;;; furnished to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be
;;; included in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;;; NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;;; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;;; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
;;; DEALINGS IN THE SOFTWARE.

(in-package #:trivial-features)

;;;; Endianness

(push-feature
 (fli:with-dynamic-foreign-objects ()
   (let ((ptr (fli:alloca :type :byte :nelems 2)))
     (setf (fli:dereference ptr :type '(:unsigned :short)) #xfeff)
     (ecase (fli:dereference ptr :type '(:unsigned :byte))
       (#xfe '#:big-endian)
       (#xff '#:little-endian)))))

;;;; OS

;;; Lispworks already exports:
;;;
;;;   :DARWIN
;;;   :LINUX
;;;   :UNIX

(push-feature-if '#:win32 '#:windows)

;;; Pushing :BSD.  (Make sure this list is complete.)
(push-feature-if '(:or #:darwin #:freebsd #:netbsd #:openbsd) '#:bsd)

;;;; CPU

(when (featurep 'harp::x86)
  (push-feature '#:x86))

(push-feature-if '#:powerpc '#:ppc)
