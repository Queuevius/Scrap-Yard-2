/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.0.0-1 (2019-02-04)
 */

!function(){"use strict";var e=tinymce.util.Tools.resolve("tinymce.PluginManager"),n=function(e){return e.getParam("insertdatetime_timeformat",e.translate("%H:%M:%S"))},r=function(e){return e.getParam("insertdatetime_formats",["%H:%M:%S","%Y-%m-%d","%I:%M:%S %p","%D"])},t=function(e){return e.getParam("insertdatetime_dateformat",e.translate("%Y-%m-%d"))},a=n,i=r,o=function(e){var t=r(e);return 0<t.length?t[0]:n(e)},l=function(e){return e.getParam("insertdatetime_element",!1)},u="Sun Mon Tue Wed Thu Fri Sat Sun".split(" "),c="Sunday Monday Tuesday Wednesday Thursday Friday Saturday Sunday".split(" "),m="Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec".split(" "),s="January February March April May June July August September October November December".split(" "),d=function(e,t){if((e=""+e).length<t)for(var n=0;n<t-e.length;n++)e="0"+e;return e},f=function(e,t,n){return n=n||new Date,t=(t=(t=(t=(t=(t=(t=(t=(t=(t=(t=(t=(t=(t=(t=(t=t.replace("%D","%m/%d/%Y")).replace("%r","%I:%M:%S %p")).replace("%Y",""+n.getFullYear())).replace("%y",""+n.getYear())).replace("%m",d(n.getMonth()+1,2))).replace("%d",d(n.getDate(),2))).replace("%H",""+d(n.getHours(),2))).replace("%M",""+d(n.getMinutes(),2))).replace("%S",""+d(n.getSeconds(),2))).replace("%I",""+((n.getHours()+11)%12+1))).replace("%p",n.getHours()<12?"AM":"PM")).replace("%B",""+e.translate(s[n.getMonth()]))).replace("%b",""+e.translate(m[n.getMonth()]))).replace("%A",""+e.translate(c[n.getDay()]))).replace("%a",""+e.translate(u[n.getDay()]))).replace("%%","%")},p=function(e,t){if(l(e)){var n=f(e,t),r=void 0;r=/%[HMSIp]/.test(t)?f(e,"%Y-%m-%dT%H:%M"):f(e,"%Y-%m-%d");var a=e.dom.getParent(e.selection.getStart(),"time");a?(o=a,u=r,c=n,m=(i=e).dom.create("time",{datetime:u},c),o.parentNode.insertBefore(m,o),i.dom.remove(o),i.selection.select(m,!0),i.selection.collapse(!1)):e.insertContent('<time datetime="'+r+'">'+n+"</time>")}else e.insertContent(f(e,t));var i,o,u,c,m},g=f,y=function(e){e.addCommand("mceInsertDate",function(){p(e,t(e))}),e.addCommand("mceInsertTime",function(){p(e,a(e))})},M=tinymce.util.Tools.resolve("tinymce.util.Tools"),S=function(e){var t=e,n=function(){return t};return{get:n,set:function(e){t=e},clone:function(){return S(n())}}},v=function(n){var t=i(n),r=S(o(n));n.ui.registry.addSplitButton("insertdatetime",{icon:"insert-time",tooltip:"Insert date/time",select:function(e){return e===r.get()},fetch:function(e){e(M.map(t,function(e){return{type:"choiceitem",text:g(n,e),value:e}}))},onAction:function(){for(var e=[],t=0;t<arguments.length;t++)e[t]=arguments[t];p(n,r.get())},onItemAction:function(e,t){r.set(t),p(n,t)}}),n.ui.registry.addNestedMenuItem("insertdatetime",{icon:"insert-time",text:"Date/time",getSubmenuItems:function(){return M.map(t,function(e){return{type:"menuitem",text:g(n,e),onAction:(t=e,function(){r.set(t),p(n,t)})};var t})}})};e.add("insertdatetime",function(e){y(e),v(e)}),function h(){}}();
