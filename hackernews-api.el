;;; hackernews-api.el --- HackerNews API client

;; Copyright (C) 2014 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL: https://github.com/syohex/emacs-hackernews-api
;; Version: 0.01

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'json)

(defconst hackernews-api--base-url
  "https://hacker-news.firebaseio.com/v0")

(defun hackernews-api--get (path)
  (let ((url (concat hackernews-api--base-url path)))
    (with-temp-buffer
      (unless (zerop (process-file "curl" nil t nil "-s" url))
        (error "Failed GET %s" url))
      (json-read-from-string (buffer-string)))))

;;;###autoload
(defun hackernews-api-top-story-ids ()
  (hackernews-api--get "/topstories.json"))

;;;###autoload
(defun hackernews-api-item (id)
  (hackernews-api--get (format "/item/%d.json" id)))

;;;###autoload
(defun hackernews-api-user (user-id)
  (hackernews-api--get (format "/user/%s.json" user-id)))

;;;###autoload
(defun hackernews-api-max-item-id ()
  (hackernews-api--get "/maxitem.json"))

;;;###autoload
(defun hackernews-api-updates ()
  (hackernews-api--get "/updates.json"))

(provide 'hackernews-api)

;;; hackernews-api.el ends here
