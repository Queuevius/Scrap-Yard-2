/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.0.0-1 (2019-02-04)
 */

!function(){"use strict";var e=tinymce.util.Tools.resolve("tinymce.PluginManager"),t=tinymce.util.Tools.resolve("tinymce.dom.DOMUtils"),c=tinymce.util.Tools.resolve("tinymce.EditorManager"),s=tinymce.util.Tools.resolve("tinymce.Env"),a=tinymce.util.Tools.resolve("tinymce.util.Delay"),y=tinymce.util.Tools.resolve("tinymce.util.Tools"),f=tinymce.util.Tools.resolve("tinymce.util.VK"),d=function(e){return e.getParam("tab_focus",e.getParam("tabfocus_elements",":prev,:next"))},m=t.DOM,n=function(e){e.keyCode!==f.TAB||e.ctrlKey||e.altKey||e.metaKey||e.preventDefault()},i=function(r){function e(n){var i,o,e,l;if(!(n.keyCode!==f.TAB||n.ctrlKey||n.altKey||n.metaKey||n.isDefaultPrevented())&&(1===(e=y.explode(d(r))).length&&(e[1]=e[0],e[0]=":prev"),o=n.shiftKey?":prev"===e[0]?u(-1):m.get(e[0]):":next"===e[1]?u(1):m.get(e[1]))){var t=c.get(o.id||o.name);o.id&&t?t.focus():a.setTimeout(function(){s.webkit||window.focus(),o.focus()},10),n.preventDefault()}function u(e){function t(e){return/INPUT|TEXTAREA|BUTTON/.test(e.tagName)&&c.get(n.id)&&-1!==e.tabIndex&&function t(e){return"BODY"===e.nodeName||"hidden"!==e.type&&"none"!==e.style.display&&"hidden"!==e.style.visibility&&t(e.parentNode)}(e)}if(o=m.select(":input:enabled,*[tabindex]:not(iframe)"),y.each(o,function(e,t){if(e.id===r.id)return i=t,!1}),0<e){for(l=i+1;l<o.length;l++)if(t(o[l]))return o[l]}else for(l=i-1;0<=l;l--)if(t(o[l]))return o[l];return null}}r.on("init",function(){r.inline&&m.setAttrib(r.getBody(),"tabIndex",null),r.on("keyup",n),s.gecko?r.on("keypress keydown",e):r.on("keydown",e)})};e.add("tabfocus",function(e){i(e)}),function o(){}}();
