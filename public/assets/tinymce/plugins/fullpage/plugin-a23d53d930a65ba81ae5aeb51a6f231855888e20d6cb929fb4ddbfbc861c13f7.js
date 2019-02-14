/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.0.0-1 (2019-02-04)
 */

!function(){"use strict";var o,l=function(t){var e=t,n=function(){return e};return{get:n,set:function(t){e=t},clone:function(){return l(n())}}},t=tinymce.util.Tools.resolve("tinymce.PluginManager"),m=tinymce.util.Tools.resolve("tinymce.util.Tools"),e=tinymce.util.Tools.resolve("tinymce.html.DomParser"),f=tinymce.util.Tools.resolve("tinymce.html.Node"),g=tinymce.util.Tools.resolve("tinymce.html.Serializer"),p=function(t){return t.getParam("fullpage_hide_in_source_view")},r=function(t){return t.getParam("fullpage_default_xml_pi")},a=function(t){return t.getParam("fullpage_default_encoding")},c=function(t){return t.getParam("fullpage_default_font_family")},s=function(t){return t.getParam("fullpage_default_font_size")},u=function(t){return t.getParam("fullpage_default_text_color")},d=function(t){return t.getParam("fullpage_default_title")},y=function(t){return t.getParam("fullpage_default_doctype","<!DOCTYPE html>")},h=function(t){return e({validate:!1,root_name:"#document"}).parse(t)},v=h,n=function(t,e){var n,l,i=h(e),r={};function o(t,e){return t.attr(e)||""}return r.fontface=c(t),r.fontsize=s(t),7===(n=i.firstChild).type&&(r.xml_pi=!0,(l=/encoding="([^"]+)"/.exec(n.value))&&(r.docencoding=l[1])),(n=i.getAll("#doctype")[0])&&(r.doctype="<!DOCTYPE"+n.value+">"),(n=i.getAll("title")[0])&&n.firstChild&&(r.title=n.firstChild.value),m.each(i.getAll("meta"),function(t){var e,n=t.attr("name"),l=t.attr("http-equiv");n?r[n.toLowerCase()]=t.attr("content"):"Content-Type"===l&&(e=/charset\s*=\s*(.*)\s*/gi.exec(t.attr("content")))&&(r.docencoding=e[1])}),(n=i.getAll("html")[0])&&(r.langcode=o(n,"lang")||o(n,"xml:lang")),r.stylesheets=[],m.each(i.getAll("link"),function(t){"stylesheet"===t.attr("rel")&&r.stylesheets.push(t.attr("href"))}),(n=i.getAll("body")[0])&&(r.langdir=o(n,"dir"),r.style=o(n,"style"),r.visited_color=o(n,"vlink"),r.link_color=o(n,"link"),r.active_color=o(n,"alink")),r},_=function(t,r,e){var o,n,l,a,i,c=t.dom;function s(t,e,n){t.attr(e,n||undefined)}function u(t){n.firstChild?n.insert(t,n.firstChild):n.append(t)}o=h(e),(n=o.getAll("head")[0])||(a=o.getAll("html")[0],n=new f("head",1),a.firstChild?a.insert(n,a.firstChild,!0):a.append(n)),a=o.firstChild,r.xml_pi?(i='version="1.0"',r.docencoding&&(i+=' encoding="'+r.docencoding+'"'),7!==a.type&&(a=new f("xml",7),o.insert(a,o.firstChild,!0)),a.value=i):a&&7===a.type&&a.remove(),a=o.getAll("#doctype")[0],r.doctype?(a||(a=new f("#doctype",10),r.xml_pi?o.insert(a,o.firstChild):u(a)),a.value=r.doctype.substring(9,r.doctype.length-1)):a&&a.remove(),a=null,m.each(o.getAll("meta"),function(t){"Content-Type"===t.attr("http-equiv")&&(a=t)}),r.docencoding?(a||((a=new f("meta",1)).attr("http-equiv","Content-Type"),a.shortEnded=!0,u(a)),a.attr("content","text/html; charset="+r.docencoding)):a&&a.remove(),a=o.getAll("title")[0],r.title?(a?a.empty():u(a=new f("title",1)),a.append(new f("#text",3)).value=r.title):a&&a.remove(),m.each("keywords,description,author,copyright,robots".split(","),function(t){var e,n,l=o.getAll("meta"),i=r[t];for(e=0;e<l.length;e++)if((n=l[e]).attr("name")===t)return void(i?n.attr("content",i):n.remove());i&&((a=new f("meta",1)).attr("name",t),a.attr("content",i),a.shortEnded=!0,u(a))});var d={};return m.each(o.getAll("link"),function(t){"stylesheet"===t.attr("rel")&&(d[t.attr("href")]=t)}),m.each(r.stylesheets,function(t){d[t]||((a=new f("link",1)).attr({rel:"stylesheet",text:"text/css",href:t}),a.shortEnded=!0,u(a)),delete d[t]}),m.each(d,function(t){t.remove()}),(a=o.getAll("body")[0])&&(s(a,"dir",r.langdir),s(a,"style",r.style),s(a,"vlink",r.visited_color),s(a,"link",r.link_color),s(a,"alink",r.active_color),c.setAttribs(t.getBody(),{style:r.style,dir:r.dir,vLink:r.visited_color,link:r.link_color,aLink:r.active_color})),(a=o.getAll("html")[0])&&(s(a,"lang",r.langcode),s(a,"xml:lang",r.langcode)),n.firstChild||n.remove(),(l=g({validate:!1,indent:!0,apply_source_formatting:!0,indent_before:"head,html,body,meta,title,script,link,style",indent_after:"head,html,body,meta,title,script,link,style"}).serialize(o)).substring(0,l.indexOf("</body>"))},b=Object.prototype.hasOwnProperty,x=(o=function(t,e){return e},function(){for(var t=new Array(arguments.length),e=0;e<t.length;e++)t[e]=arguments[e];if(0===t.length)throw new Error("Can't merge zero objects");for(var n={},l=0;l<t.length;l++){var i=t[l];for(var r in i)b.call(i,r)&&(n[r]=o(n[r],i[r]))}return n}),i=function(l,i){var r=n(l,i.get()),t=x({title:"",keywords:"",description:"",robots:"",author:"",docencoding:""},r);l.windowManager.open({title:"Metadata and Document Properties",size:"normal",body:{type:"panel",items:[{name:"title",type:"input",label:"Title"},{name:"keywords",type:"input",label:"Keywords"},{name:"description",type:"input",label:"Description"},{name:"robots",type:"input",label:"Robots"},{name:"author",type:"input",label:"Author"},{name:"docencoding",type:"input",label:"Encoding"}]},buttons:[{type:"cancel",name:"cancel",text:"Cancel"},{type:"submit",name:"save",text:"Save",primary:!0}],initialData:t,onSubmit:function(t){var e=t.getData(),n=_(l,m.extend(r,e),i.get());i.set(n),t.close()}})},k=function(t,e){t.addCommand("mceFullPageProperties",function(){i(t,e)})},C=function(t,e){return m.each(t,function(t){e=e.replace(t,function(t){return"\x3c!--mce:protected "+escape(t)+"--\x3e"})}),e},A=function(t){return t.replace(/<!--mce:protected ([\s\S]*?)-->/g,function(t,e){return unescape(e)})},w=m.each,P=function(t){return t.replace(/<\/?[A-Z]+/g,function(t){return t.toLowerCase()})},T=function(t){var e,n="",l="";if(r(t)){var i=a(t);n+='<?xml version="1.0" encoding="'+(i||"ISO-8859-1")+'" ?>\n'}return n+=y(t),n+="\n<html>\n<head>\n",(e=d(t))&&(n+="<title>"+e+"</title>\n"),(e=a(t))&&(n+='<meta http-equiv="Content-Type" content="text/html; charset='+e+'" />\n'),(e=c(t))&&(l+="font-family: "+e+";"),(e=s(t))&&(l+="font-size: "+e+";"),(e=u(t))&&(l+="color: "+e+";"),n+="</head>\n<body"+(l?' style="'+l+'"':"")+">\n"},O=function(r,o,a){r.on("BeforeSetContent",function(t){!function(t,e,n,l){var i,r,o,a,c,s="",u=t.dom;if(!(l.selection||(o=C(t.settings.protect,l.content),"raw"===l.format&&e.get()||l.source_view&&p(t)))){0!==o.length||l.source_view||(o=m.trim(e.get())+"\n"+m.trim(o)+"\n"+m.trim(n.get())),-1!==(i=(o=o.replace(/<(\/?)BODY/gi,"<$1body")).indexOf("<body"))?(i=o.indexOf(">",i),e.set(P(o.substring(0,i+1))),-1===(r=o.indexOf("</body",i))&&(r=o.length),l.content=m.trim(o.substring(i+1,r)),n.set(P(o.substring(r)))):(e.set(T(t)),n.set("\n</body>\n</html>")),a=v(e.get()),w(a.getAll("style"),function(t){t.firstChild&&(s+=t.firstChild.value)}),(c=a.getAll("body")[0])&&u.setAttribs(t.getBody(),{style:c.attr("style")||"",dir:c.attr("dir")||"",vLink:c.attr("vlink")||"",link:c.attr("link")||"",aLink:c.attr("alink")||""}),u.remove("fullpage_styles");var d=t.getDoc().getElementsByTagName("head")[0];s&&(u.add(d,"style",{id:"fullpage_styles"},s),(c=u.get("fullpage_styles")).styleSheet&&(c.styleSheet.cssText=s));var f={};m.each(d.getElementsByTagName("link"),function(t){"stylesheet"===t.rel&&t.getAttribute("data-mce-fullpage")&&(f[t.href]=t)}),m.each(a.getAll("link"),function(t){var e=t.attr("href");if(!e)return!0;f[e]||"stylesheet"!==t.attr("rel")||u.add(d,"link",{rel:"stylesheet",text:"text/css",href:e,"data-mce-fullpage":"1"}),delete f[e]}),m.each(f,function(t){t.parentNode.removeChild(t)})}}(r,o,a,t)}),r.on("GetContent",function(t){var e,n,l,i;e=r,n=o.get(),l=a.get(),(i=t).selection||i.source_view&&p(e)||(i.content=A(m.trim(n)+"\n"+m.trim(i.content)+"\n"+m.trim(l)))})},D=function(t){t.ui.registry.addButton("fullpage",{tooltip:"Metadata and document properties",icon:"document-properties",onAction:function(){t.execCommand("mceFullPageProperties")}}),t.ui.registry.addMenuItem("fullpage",{text:"Metadata and document properties",icon:"document-properties",onAction:function(){t.execCommand("mceFullPageProperties")}})};t.add("fullpage",function(t){var e=l(""),n=l("");k(t,e),D(t),O(t,e,n)}),function E(){}}();
