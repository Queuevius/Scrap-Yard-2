/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.1.1 (2019-10-28)
 */

!function(c){"use strict";function n(t){return function(n){return function(n){if(null===n)return"null";var t=typeof n;return"object"==t&&(Array.prototype.isPrototypeOf(n)||n.constructor&&"Array"===n.constructor.name)?"array":"object"==t&&(String.prototype.isPrototypeOf(n)||n.constructor&&"String"===n.constructor.name)?"string":t}(n)===t}}function u(){}function i(n){return function(){return n}}function t(){return O}var e,r=tinymce.util.Tools.resolve("tinymce.PluginManager"),o=tinymce.util.Tools.resolve("tinymce.util.VK"),a=n("string"),f=n("array"),l=n("boolean"),s=n("function"),d=function(n){var t=n.getParam("link_assume_external_targets",!1);return l(t)&&t?1:!a(t)||"http"!==t&&"https"!==t?0:t},m=function(n){return n.getParam("link_context_toolbar",!1,"boolean")},h=function(n){return n.getParam("link_list")},p=function(n){return n.getParam("default_link_target")},g=function(n){return n.getParam("target_list",!0)},v=function(n){return n.getParam("rel_list",[],"array")},y=function(n){return n.getParam("link_class_list",[],"array")},w=function(n){return n.getParam("link_title",!0,"boolean")},x=function(n){return n.getParam("allow_unsafe_link_target",!1,"boolean")},k=function(n){return n.getParam("link_quicklink",!1,"boolean")},b=function(n){var t=c.document.createElement("a");t.target="_blank",t.href=n,t.rel="noreferrer noopener";var e=c.document.createEvent("MouseEvents");e.initMouseEvent("click",!0,!0,c.window,0,0,0,0,0,!1,!1,!1,!1,0,null),function(n,t){c.document.body.appendChild(n),n.dispatchEvent(t),c.document.body.removeChild(n)}(t,e)},_=i(!1),T=i(!0),O=(e={fold:function(n,t){return n()},is:_,isSome:_,isNone:T,getOr:P,getOrThunk:C,getOrDie:function(n){throw new Error(n||"error: getOrDie called on none.")},getOrNull:i(null),getOrUndefined:i(undefined),or:P,orThunk:C,map:t,each:u,bind:t,exists:_,forall:T,filter:t,equals:A,equals_:A,toArray:function(){return[]},toString:i("none()")},Object.freeze&&Object.freeze(e),e);function A(n){return n.isNone()}function C(n){return n()}function P(n){return n}function N(n,t){return-1<function(n,t){return J.call(n,t)}(n,t)}function E(n,t){for(var e=0,r=n.length;e<r;e++){t(n[e],e)}}function I(n){for(var t=[],e=0,r=n.length;e<r;++e){if(!f(n[e]))throw new Error("Arr.flatten item "+e+" was not an array, input: "+n);X.apply(t,n[e])}return t}function S(n,t){var e=function(n,t){for(var e=n.length,r=new Array(e),o=0;o<e;o++){var i=n[o];r[o]=t(i,o)}return r}(n,t);return I(e)}function j(n){return/^\w+:/i.test(n)}function F(n,t){var e,r,o=["noopener"],i=n?n.split(/\s+/):[],u=function(n){return n.filter(function(n){return-1===Q.inArray(o,n)})},c=t?0<(e=u(e=i)).length?e.concat(o):o:u(i);return 0<c.length?(r=c,Q.trim(r.sort().join(" "))):""}function L(n,t){return t=t||n.selection.getNode(),Y(t)?n.dom.select("a[href]",t)[0]:n.dom.getParent(t,"a[href]")}function R(n){return n&&"A"===n.nodeName&&!!n.href}function D(n){return function(n,t,e){return E(n,function(n){e=t(e,n)}),e}(["title","rel","class","target"],function(t,e){return n[e].each(function(n){t[e]=0<n.length?n:null}),t},{href:n.href})}function U(n,t){for(var e=0;e<n.length;e++){var r=t(n[e],e);if(r.isSome())return r}return $.none()}function M(n){return a(n.value)?n.value:""}function z(t){return void 0===t&&(t=M),function(n){return $.from(n).map(function(n){return function(n,r){var o=[];return Q.each(n,function(n){var t=a(n.text)?n.text:a(n.title)?n.title:"";if(n.menu!==undefined);else{var e=r(n);o.push({text:t,value:e})}}),o}(n,t)})}}function q(t,n,e,r){var o=r[n],i=0<t.length;return o!==undefined?function(t,n){return U(n,function(n){return $.some(n).filter(function(n){return n.value===t})})}(o,e).map(function(n){return{url:{value:n.value,meta:{text:i?t:n.text,attach:u}},text:i?t:n.text}}):$.none()}var K,B,V,W,H=function(e){function n(){return o}function t(n){return n(e)}var r=i(e),o={fold:function(n,t){return t(e)},is:function(n){return e===n},isSome:T,isNone:_,getOr:r,getOrThunk:r,getOrDie:r,getOrNull:r,getOrUndefined:r,or:n,orThunk:n,map:function(n){return H(n(e))},each:function(n){n(e)},bind:t,exists:t,forall:t,filter:function(n){return n(e)?o:O},toArray:function(){return[e]},toString:function(){return"some("+e+")"},equals:function(n){return n.is(e)},equals_:function(n,t){return n.fold(_,function(n){return t(e,n)})}};return o},$={some:H,none:t,from:function(n){return null===n||n===undefined?O:H(n)}},G=Array.prototype.slice,J=Array.prototype.indexOf,X=Array.prototype.push,Q=(s(Array.from)&&Array.from,tinymce.util.Tools.resolve("tinymce.util.Tools")),Y=function(n){return n&&"FIGURE"===n.nodeName&&/\bimage\b/i.test(n.className)},Z=function(n,t){var e=n.dom.select("img",t)[0];if(e){var r=n.dom.getParents(e,"a[href]",t)[0];r&&(r.parentNode.insertBefore(e,r),n.dom.remove(r))}},nn=function(n,t,e){var r=n.dom.select("img",t)[0];if(r){var o=n.dom.create("a",e);r.parentNode.insertBefore(o,r),o.appendChild(r)}},tn=function(o,i,u){o.undoManager.transact(function(){var n=o.selection.getNode(),t=L(o,n),e=D(u);if(!(0<v(o).length)&&!1===x(o)){var r=F(e.rel,"_blank"===e.target);e.rel=r||null}$.from(e.target).isNone()&&(e.target=p(o)),e.href=function(n,t){return"http"!==t&&"https"!==t||j(n)?n:t+"://"+n}(e.href,d(o)),u.href===i.href&&i.attach(),t?(o.focus(),function(n,t,e,r){e.each(function(n){t.hasOwnProperty("innerText")?t.innerText=n:t.textContent=n}),n.dom.setAttribs(t,r),n.selection.select(t)}(o,t,u.text,e)):function(t,n,e,r){Y(n)?nn(t,n,r):e.fold(function(){t.execCommand("mceInsertLink",!1,r)},function(n){t.insertContent(t.dom.createHTML("a",r,t.dom.encode(n)))})}(o,n,u.text,e)})},en=function(e){e.undoManager.transact(function(){var n=e.selection.getNode();if(Y(n))Z(e,n);else{var t=e.dom.getParent(n,"a[href]",e.getBody());t&&e.dom.remove(t,!0)}e.focus()})},rn=function(n){return 0<Q.grep(n,R).length},on=function(n){var t=n.getAttribute("data-mce-href");return t||n.getAttribute("href")},un=function(n){return!(/</.test(n)&&(!/^<a [^>]+>[^<]+<\/a>$/.test(n)||-1===n.indexOf("href=")))},cn=L,an=function(n,t){return function(n){return n.replace(/\uFEFF/g,"")}(t?t.innerText||t.textContent:n.getContent({format:"text"}))},fn=F,ln=j,sn={sanitize:function(n){return z(M)(n)},sanitizeWith:z,createUi:function(t,e){return function(n){return{name:t,type:"selectbox",label:e,items:n}}},getValue:M},dn=function(n){function t(){return e}var e=n;return{get:t,set:function(n){e=n},clone:function(){return dn(t())}}},mn=function(n,r){function e(n,t){var e=function(n,t){return"link"===t?n.catalogs.link:"anchor"===t?n.catalogs.anchor:$.none()}(r,t.name).getOr([]);return q(o.get(),t.name,e,n)}var o=dn(n.text);return{onChange:function(n,t){return"url"===t.name?function(n){if(o.get().length<=0){var t=n.url.meta.text!==undefined?n.url.meta.text:n.url.value;return $.some({text:t})}return $.none()}(n()):N(["anchor","link"],t.name)?e(n(),t):("text"===t.name&&o.set(n().text),$.none())}}},hn=function(){return(hn=Object.assign||function(n){for(var t,e=1,r=arguments.length;e<r;e++)for(var o in t=arguments[e])Object.prototype.hasOwnProperty.call(t,o)&&(n[o]=t[o]);return n}).apply(this,arguments)},pn={},gn={exports:pn};K=undefined,B=pn,V=gn,W=undefined,function(n){"object"==typeof B&&void 0!==V?V.exports=n():"function"==typeof K&&K.amd?K([],n):("undefined"!=typeof window?window:"undefined"!=typeof global?global:"undefined"!=typeof self?self:this).EphoxContactWrapper=n()}(function(){return function l(i,u,c){function a(t,n){if(!u[t]){if(!i[t]){var e="function"==typeof W&&W;if(!n&&e)return e(t,!0);if(f)return f(t,!0);var r=new Error("Cannot find module '"+t+"'");throw r.code="MODULE_NOT_FOUND",r}var o=u[t]={exports:{}};i[t][0].call(o.exports,function(n){return a(i[t][1][n]||n)},o,o.exports,l,i,u,c)}return u[t].exports}for(var f="function"==typeof W&&W,n=0;n<c.length;n++)a(c[n]);return a}({1:[function(n,t,e){var r,o,i=t.exports={};function u(){throw new Error("setTimeout has not been defined")}function c(){throw new Error("clearTimeout has not been defined")}function a(n){if(r===setTimeout)return setTimeout(n,0);if((r===u||!r)&&setTimeout)return r=setTimeout,setTimeout(n,0);try{return r(n,0)}catch(t){try{return r.call(null,n,0)}catch(t){return r.call(this,n,0)}}}!function(){try{r="function"==typeof setTimeout?setTimeout:u}catch(n){r=u}try{o="function"==typeof clearTimeout?clearTimeout:c}catch(n){o=c}}();var f,l=[],s=!1,d=-1;function m(){s&&f&&(s=!1,f.length?l=f.concat(l):d=-1,l.length&&h())}function h(){if(!s){var n=a(m);s=!0;for(var t=l.length;t;){for(f=l,l=[];++d<t;)f&&f[d].run();d=-1,t=l.length}f=null,s=!1,function e(n){if(o===clearTimeout)return clearTimeout(n);if((o===c||!o)&&clearTimeout)return o=clearTimeout,clearTimeout(n);try{return o(n)}catch(t){try{return o.call(null,n)}catch(t){return o.call(this,n)}}}(n)}}function p(n,t){this.fun=n,this.array=t}function g(){}i.nextTick=function(n){var t=new Array(arguments.length-1);if(1<arguments.length)for(var e=1;e<arguments.length;e++)t[e-1]=arguments[e];l.push(new p(n,t)),1!==l.length||s||a(h)},p.prototype.run=function(){this.fun.apply(null,this.array)},i.title="browser",i.browser=!0,i.env={},i.argv=[],i.version="",i.versions={},i.on=g,i.addListener=g,i.once=g,i.off=g,i.removeListener=g,i.removeAllListeners=g,i.emit=g,i.prependListener=g,i.prependOnceListener=g,i.listeners=function(n){return[]},i.binding=function(n){throw new Error("process.binding is not supported")},i.cwd=function(){return"/"},i.chdir=function(n){throw new Error("process.chdir is not supported")},i.umask=function(){return 0}},{}],2:[function(n,s,t){(function(t){function r(){}function i(n){if("object"!=typeof this)throw new TypeError("Promises must be constructed via new");if("function"!=typeof n)throw new TypeError("not a function");this._state=0,this._handled=!1,this._value=undefined,this._deferreds=[],l(n,this)}function o(r,o){for(;3===r._state;)r=r._value;0!==r._state?(r._handled=!0,i._immediateFn(function(){var n=1===r._state?o.onFulfilled:o.onRejected;if(null!==n){var t;try{t=n(r._value)}catch(e){return void c(o.promise,e)}u(o.promise,t)}else(1===r._state?u:c)(o.promise,r._value)})):r._deferreds.push(o)}function u(n,t){try{if(t===n)throw new TypeError("A promise cannot be resolved with itself.");if(t&&("object"==typeof t||"function"==typeof t)){var e=t.then;if(t instanceof i)return n._state=3,n._value=t,void a(n);if("function"==typeof e)return void l(function r(n,t){return function(){n.apply(t,arguments)}}(e,t),n)}n._state=1,n._value=t,a(n)}catch(o){c(n,o)}}function c(n,t){n._state=2,n._value=t,a(n)}function a(n){2===n._state&&0===n._deferreds.length&&i._immediateFn(function(){n._handled||i._unhandledRejectionFn(n._value)});for(var t=0,e=n._deferreds.length;t<e;t++)o(n,n._deferreds[t]);n._deferreds=null}function f(n,t,e){this.onFulfilled="function"==typeof n?n:null,this.onRejected="function"==typeof t?t:null,this.promise=e}function l(n,t){var e=!1;try{n(function(n){e||(e=!0,u(t,n))},function(n){e||(e=!0,c(t,n))})}catch(r){if(e)return;e=!0,c(t,r)}}var n,e;n=this,e=setTimeout,i.prototype["catch"]=function(n){return this.then(null,n)},i.prototype.then=function(n,t){var e=new this.constructor(r);return o(this,new f(n,t,e)),e},i.all=function(n){var a=Array.prototype.slice.call(n);return new i(function(o,i){if(0===a.length)return o([]);var u=a.length;function c(t,n){try{if(n&&("object"==typeof n||"function"==typeof n)){var e=n.then;if("function"==typeof e)return void e.call(n,function(n){c(t,n)},i)}a[t]=n,0==--u&&o(a)}catch(r){i(r)}}for(var n=0;n<a.length;n++)c(n,a[n])})},i.resolve=function(t){return t&&"object"==typeof t&&t.constructor===i?t:new i(function(n){n(t)})},i.reject=function(e){return new i(function(n,t){t(e)})},i.race=function(o){return new i(function(n,t){for(var e=0,r=o.length;e<r;e++)o[e].then(n,t)})},i._immediateFn="function"==typeof t?function(n){t(n)}:function(n){e(n,0)},i._unhandledRejectionFn=function(n){"undefined"!=typeof console&&console&&console.warn("Possible Unhandled Promise Rejection:",n)},i._setImmediateFn=function(n){i._immediateFn=n},i._setUnhandledRejectionFn=function(n){i._unhandledRejectionFn=n},void 0!==s&&s.exports?s.exports=i:n.Promise||(n.Promise=i)}).call(this,n("timers").setImmediate)},{timers:3}],3:[function(a,n,f){(function(n,t){var r=a("process/browser.js").nextTick,e=Function.prototype.apply,o=Array.prototype.slice,i={},u=0;function c(n,t){this._id=n,this._clearFn=t}f.setTimeout=function(){return new c(e.call(setTimeout,window,arguments),clearTimeout)},f.setInterval=function(){return new c(e.call(setInterval,window,arguments),clearInterval)},f.clearTimeout=f.clearInterval=function(n){n.close()},c.prototype.unref=c.prototype.ref=function(){},c.prototype.close=function(){this._clearFn.call(window,this._id)},f.enroll=function(n,t){clearTimeout(n._idleTimeoutId),n._idleTimeout=t},f.unenroll=function(n){clearTimeout(n._idleTimeoutId),n._idleTimeout=-1},f._unrefActive=f.active=function(n){clearTimeout(n._idleTimeoutId);var t=n._idleTimeout;0<=t&&(n._idleTimeoutId=setTimeout(function(){n._onTimeout&&n._onTimeout()},t))},f.setImmediate="function"==typeof n?n:function(n){var t=u++,e=!(arguments.length<2)&&o.call(arguments,1);return i[t]=!0,r(function(){i[t]&&(e?n.apply(null,e):n.call(null),f.clearImmediate(t))}),t},f.clearImmediate="function"==typeof t?t:function(n){delete i[n]}}).call(this,a("timers").setImmediate,a("timers").clearImmediate)},{"process/browser.js":1,timers:3}],4:[function(n,t,e){var r=n("promise-polyfill"),o="undefined"!=typeof window?window:Function("return this;")();t.exports={boltExport:o.Promise||r}},{"promise-polyfill":2}]},{},[4])(4)});function vn(n){c.setTimeout(function(){throw n},0)}function yn(n){var t=n.href;return 0<t.indexOf("@")&&-1===t.indexOf("//")&&-1===t.indexOf("mailto:")?$.some({message:"The URL you entered seems to be an email address. Do you want to add the required mailto: prefix?",preprocess:function(n){return hn(hn({},n),{href:"mailto:"+t})}}):$.none()}function wn(n,t,e){var r=n.getAttrib(t,e);return null!==r&&0<r.length?$.some(r):$.none()}function xn(n,t){return n.dom.getParent(t,"a[href]")}function kn(n){return xn(n,n.selection.getStart())}function bn(n,t){if(t){var e=on(t);if(/^#/.test(e)){var r=n.$(e);r.length&&n.selection.scrollIntoView(r[0],!0)}else b(t.href)}}var _n=gn.exports.boltExport,Tn=function(n){var e=$.none(),t=[],r=function(n){o()?u(n):t.push(n)},o=function(){return e.isSome()},i=function(n){E(n,u)},u=function(t){e.each(function(n){c.setTimeout(function(){t(n)},0)})};return n(function(n){e=$.some(n),i(t),t=[]}),{get:r,map:function(e){return Tn(function(t){r(function(n){t(e(n))})})},isReady:o}},On={nu:Tn,pure:function(t){return Tn(function(n){n(t)})}},An=function(e){function n(n){e().then(n,vn)}return{map:function(n){return An(function(){return e().then(n)})},bind:function(t){return An(function(){return e().then(function(n){return t(n).toPromise()})})},anonBind:function(n){return An(function(){return e().then(function(){return n.toPromise()})})},toLazy:function(){return On.nu(n)},toCached:function(){var n=null;return An(function(){return null===n&&(n=e()),n})},toPromise:e,get:n}},Cn=function(n){return An(function(){return new _n(n)})},Pn=function(n){return An(function(){return _n.resolve(n)})},Nn=tinymce.util.Tools.resolve("tinymce.util.Delay"),En=function(n,t,r){return U([yn,function(e){return function(n){var t=n.href;return 1===e&&!ln(t)||0===e&&/^\s*www[\.|\d\.]/i.test(t)?$.some({message:"The URL you entered seems to be an external link. Do you want to add the required http:// prefix?",preprocess:function(n){return hn(hn({},n),{href:"http://"+t})}}):$.none()}}(t)],function(n){return n(r)}).fold(function(){return Pn(r)},function(e){return Cn(function(t){!function(t,n,e){var r=t.selection.getRng();Nn.setEditorTimeout(t,function(){t.windowManager.confirm(n,function(n){t.selection.setRng(r),e(n)})})}(n,e.message,function(n){t(n?e.preprocess(r):r)})})})},In=function(n){var t=n.dom.select("a:not([href])"),e=S(t,function(n){var t=n.name||n.id;return t?[{text:t,value:"#"+t}]:[]});return 0<e.length?$.some([{text:"None",value:""}].concat(e)):$.none()},Sn=function(n){var t=y(n);return 0<t.length?sn.sanitize(t):$.none()},jn=tinymce.util.Tools.resolve("tinymce.util.XHR"),Fn=function(t){function e(n){return t.convertURL(n.value||n.url,"href")}var n=h(t);return Cn(function(t){a(n)?jn.send({url:n,success:function(n){return t(function(n){try{return $.some(JSON.parse(n))}catch(t){return $.none()}}(n))},error:function(n){return t($.none())}}):s(n)?n(function(n){return t($.some(n))}):t($.from(n))}).map(function(n){return n.bind(sn.sanitizeWith(e)).map(function(n){return 0<n.length?[{text:"None",value:""}].concat(n):n})})},Ln=function(n,t){var e=v(n);if(0<e.length){var r=t.is("_blank");return(!1===x(n)?sn.sanitizeWith(function(n){return fn(sn.getValue(n),r)}):sn.sanitize)(e)}return $.none()},Rn=[{text:"Current window",value:""},{text:"New window",value:"_blank"}],Dn=function(n){var t=g(n);return f(t)?sn.sanitize(t).orThunk(function(){return $.some(Rn)}):!1===t?$.none():$.some(Rn)},Un=function(e,r){return Fn(e).map(function(n){var t=function(n,t){var e=n.dom,r=un(n.selection.getContent())?$.some(an(n.selection,t)):$.none(),o=t?$.some(e.getAttrib(t,"href")):$.none(),i=t?$.from(e.getAttrib(t,"target")):$.none(),u=wn(e,t,"rel"),c=wn(e,t,"class");return{url:o,text:r,title:wn(e,t,"title"),target:i,rel:u,linkClass:c}}(e,r);return{anchor:t,catalogs:{targets:Dn(e),rels:Ln(e,t.target),classes:Sn(e),anchor:In(e),link:n},optNode:$.from(r),flags:{titleEnabled:w(e)}}})},Mn=function(t){(function(n){var t=cn(n);return Un(n,t)})(t).map(function(n){return function(n,t,e){var r=n.anchor.text.map(function(){return{name:"text",type:"input",label:"Text to display"}}).toArray(),o=n.flags.titleEnabled?[{name:"title",type:"input",label:"Title"}]:[],i=function(n,t){return{url:{value:n.anchor.url.getOr(""),meta:{attach:function(){},text:n.anchor.url.fold(function(){return""},function(){return n.anchor.text.getOr("")}),original:{value:n.anchor.url.getOr("")}}},text:n.anchor.text.getOr(""),title:n.anchor.title.getOr(""),anchor:n.anchor.url.getOr(""),link:n.anchor.url.getOr(""),rel:n.anchor.rel.getOr(""),target:n.anchor.target.or(t).getOr(""),linkClass:n.anchor.linkClass.getOr("")}}(n,$.from(p(e))),u=mn(i,n),c=n.catalogs;return{title:"Insert/Edit Link",size:"normal",body:{type:"panel",items:I([[{name:"url",type:"urlinput",filetype:"file",label:"URL"}],r,o,function(n){for(var t=[],e=function(n){t.push(n)},r=0;r<n.length;r++)n[r].each(e);return t}([c.anchor.map(sn.createUi("anchor","Anchors")),c.rels.map(sn.createUi("rel","Rel")),c.targets.map(sn.createUi("target","Open link in...")),c.link.map(sn.createUi("link","Link list")),c.classes.map(sn.createUi("linkClass","Class"))])])},buttons:[{type:"cancel",name:"cancel",text:"Cancel"},{type:"submit",name:"save",text:"Save",primary:!0}],initialData:i,onChange:function(t,n){var e=n.name;u.onChange(t.getData,{name:e}).each(function(n){t.setData(n)})},onSubmit:t}}(n,function(i,u,c){return function(n){var e=n.getData();if(!e.url.value)return en(i),void n.close();function t(t){return $.from(e[t]).filter(function(n){return!u.anchor[t].is(n)})}var r={href:e.url.value,text:t("text"),target:t("target"),rel:t("rel"),"class":t("linkClass"),title:t("title")},o={href:e.url.value,attach:e.url.meta!==undefined&&e.url.meta.attach?e.url.meta.attach:function(){}};En(i,c,r).get(function(n){tn(i,o,n)}),n.close()}}(t,n,d(t)),t)}).get(function(n){t.windowManager.open(n)})},zn=function(n){return function(){Mn(n)}},qn=function(n){return function(){bn(n,kn(n))}},Kn=function(e){e.on("click",function(n){var t=xn(e,n.target);t&&o.metaKeyPressed(n)&&(n.preventDefault(),bn(e,t))}),e.on("keydown",function(n){var t=kn(e);t&&13===n.keyCode&&function(n){return!0===n.altKey&&!1===n.shiftKey&&!1===n.ctrlKey&&!1===n.metaKey}(n)&&(n.preventDefault(),bn(e,t))})},Bn=function(e){return function(t){function n(n){return t.setActive(!e.readonly&&!!cn(e,n.element))}return e.on("NodeChange",n),function(){return e.off("NodeChange",n)}}},Vn=function(e){return function(t){t.setDisabled(!rn(e.dom.getParents(e.selection.getStart())));function n(n){return t.setDisabled(!rn(n.parents))}return e.on("NodeChange",n),function(){return e.off("NodeChange",n)}}},Wn=function(n){n.addCommand("mceLink",function(){k(n)?n.fire("contexttoolbar-show",{toolbarKey:"quicklink"}):zn(n)()})},Hn=function(n){n.addShortcut("Meta+K","",function(){n.execCommand("mceLink")})},$n=function(n){n.ui.registry.addToggleButton("link",{icon:"link",tooltip:"Insert/edit link",onAction:zn(n),onSetup:Bn(n)}),n.ui.registry.addButton("openlink",{icon:"new-tab",tooltip:"Open link",onAction:qn(n),onSetup:Vn(n)}),n.ui.registry.addButton("unlink",{icon:"unlink",tooltip:"Remove link",onAction:function(){return en(n)},onSetup:Vn(n)})},Gn=function(n){n.ui.registry.addMenuItem("openlink",{text:"Open link",icon:"new-tab",onAction:qn(n),onSetup:Vn(n)}),n.ui.registry.addMenuItem("link",{icon:"link",text:"Link...",shortcut:"Meta+K",onAction:zn(n)}),n.ui.registry.addMenuItem("unlink",{icon:"unlink",text:"Remove link",onAction:function(){return en(n)},onSetup:Vn(n)})},Jn=function(t){t.ui.registry.addContextMenu("link",{update:function(n){return rn(t.dom.getParents(n,"a"))?"link unlink openlink":"link"}})},Xn=function(i){function n(n){var t=i.selection.getNode();return n.setDisabled(!cn(i,t)),function(){}}i.ui.registry.addContextForm("quicklink",{launch:{type:"contextformtogglebutton",icon:"link",tooltip:"Link",onSetup:Bn(i)},label:"Link",predicate:function(n){return!!cn(i,n)&&m(i)},initValue:function(){var n=cn(i);return n?on(n):""},commands:[{type:"contextformtogglebutton",icon:"link",tooltip:"Link",primary:!0,onSetup:function(n){var t=i.selection.getNode();return n.setActive(!!cn(i,t)),Bn(i)(n)},onAction:function(n){var t=cn(i),e=n.getValue();if(t)i.dom.setAttrib(t,"href",e),function(n){n.selection.collapse(!1)}(i),n.hide();else{var r={href:e,attach:function(){}},o=un(i.selection.getContent())?$.some(an(i.selection,t)).filter(function(n){return 0<n.length}).or($.from(e)):$.none();tn(i,r,{href:e,text:o,title:$.none(),rel:$.none(),target:$.none(),"class":$.none()}),n.hide()}}},{type:"contextformbutton",icon:"unlink",tooltip:"Remove link",onSetup:n,onAction:function(n){en(i),n.hide()}},{type:"contextformbutton",icon:"new-tab",tooltip:"Open link",onSetup:n,onAction:function(n){qn(i)(),n.hide()}}]})};!function Qn(){r.add("link",function(n){$n(n),Gn(n),Jn(n),Xn(n),Kn(n),Wn(n),Hn(n)})}()}(window);
