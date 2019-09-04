(defun hello(name)
  (insert "hello" name))

(hello "you")helloyou

(progn
  (switch-to-buffer-other-window "*test*")
  (hello "you"))

(progn
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (hello "there")
  (other-window 1))

;; bind a value to a local variable with 'let'
(let ((local-name "you"))
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (hello local-name)
  (other-window 1)
  )

(progn "me" "you")

(progn (print "hi") (message "me"))

(defun greeting (name)
(let ((you-name "revolt"))
  (insert (format "Hello %s!\n\n I am %s"
                  name
                  you-name))))

(greeting "zhuli")

(read-from-minibuffer "Enter-your-name: ")

(defun greeting (from-name)
  (let ((you-name (read-from-minibuffer "Enter your name: ")))
    (switch-to-buffer-other-window "*test*")
    (erase-buffer)
    (insert (format "hello %s!\n\nI am is %s."
                    from-name
                    you-name))
    (other-window 1)))

(greeting "lusi")

;; store list name
(setq list-of-names '("Sarah" "Chloe" "Mathilde"))

;; get the first element of this list with "car"
(car list-of-names)

(cdr list-of-names)

(push "Stephanie" list-of-names)

(car list-of-names)

(mapcar 'hello list-of-names)           ;helloStephaniehelloSarahhelloChloehelloMathilde

(defun greeting()
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  (mapcar 'hello list-of-names)
  (other-window 1))

(greeting)

(defun replace-hello-by-bonjour()
  (switch-to-buffer-other-window "*test*")
  (goto-char (point-min))
  (while (search-forward "Hello")
    (replace-match "Bonjour"))
  )

(replace-hello-by-bonjour)


;; (search-forward "Hello" nil t) 
;; nil : the search is not bound to a position
;; t : silently fail when nothing is found.

(defun hello-bonjour()
  (switch-to-buffer-other-window "*test*")
  (erase-buffer)
  ;; say hello to names in `list-of-names`
  (mapcar 'hello list-of-names)
  (goto-char (point-min))

  ;;Replace "hello" by "Bonjour"
  (while (search-forward "hello" nil t)
    (replace-match "Bonjour"))
  (other-window 1))
(hello-bonjour)


(defun boldify-names ()
    (switch-to-buffer-other-window "*test*")
    (goto-char (point-min))
    (while (re-search-forward "Bonjour \\(.+\\)!" nil t)
      (add-text-properties (match-beginning 1)
                           (match-end 1)
                           (list 'face 'red)))
    (other-window 1))

(boldify-names)

(setq mylist (list 1 "b" 3))
(message "%S" mylist)

(setq mylist '(a b c))
(message "%S" mylist)

