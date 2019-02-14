/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.0.0-1 (2019-02-04)
 */

!function(){"use strict";var e=tinymce.util.Tools.resolve("tinymce.PluginManager"),l=tinymce.util.Tools.resolve("tinymce.util.Tools"),t=function(e){return e.getParam("font_formats")},i=function(e){return e.getParam("fontsize_formats")},n=function(e,t){e.settings.fontsize_formats=t},s=function(e,t){e.settings.font_formats=t},o=function(e){return e.getParam("font_size_style_values")},r=function(e,t){e.settings.inline_styles=t},a=function(a){var e;r(e=a,!1),i(e)||n(e,"8pt=1 10pt=2 12pt=3 14pt=4 18pt=5 24pt=6 36pt=7"),t(e)||s(e,"Andale Mono=andale mono,monospace;Arial=arial,helvetica,sans-serif;Arial Black=arial black,sans-serif;Book Antiqua=book antiqua,palatino,serif;Comic Sans MS=comic sans ms,sans-serif;Courier New=courier new,courier,monospace;Georgia=georgia,palatino,serif;Helvetica=helvetica,arial,sans-serif;Impact=impact,sans-serif;Symbol=symbol;Tahoma=tahoma,arial,helvetica,sans-serif;Terminal=terminal,monaco,monospace;Times New Roman=times new roman,times,serif;Trebuchet MS=trebuchet ms,geneva,sans-serif;Verdana=verdana,geneva,sans-serif;Webdings=webdings;Wingdings=wingdings,zapf dingbats"),a.on("init",function(){return e=a,t="p,h1,h2,h3,h4,h5,h6,td,th,div,ul,ol,li,table,img",i=l.explode(o(e)),n=e.schema,e.formatter.register({alignleft:{selector:t,attributes:{align:"left"}},aligncenter:{selector:t,attributes:{align:"center"}},alignright:{selector:t,attributes:{align:"right"}},alignjustify:{selector:t,attributes:{align:"justify"}},bold:[{inline:"b",remove:"all"},{inline:"strong",remove:"all"},{inline:"span",styles:{fontWeight:"bold"}}],italic:[{inline:"i",remove:"all"},{inline:"em",remove:"all"},{inline:"span",styles:{fontStyle:"italic"}}],underline:[{inline:"u",remove:"all"},{inline:"span",styles:{textDecoration:"underline"},exact:!0}],strikethrough:[{inline:"strike",remove:"all"},{inline:"span",styles:{textDecoration:"line-through"},exact:!0}],fontname:{inline:"font",attributes:{face:"%value"}},fontsize:{inline:"font",attributes:{size:function(e){return l.inArray(i,e.value)+1}}},forecolor:{inline:"font",attributes:{color:"%value"}},hilitecolor:{inline:"font",styles:{backgroundColor:"%value"}}}),l.each("b,i,u,strike".split(","),function(e){n.addValidElements(e+"[*]")}),n.getElementRule("font")||n.addValidElements("font[face|size|color|style]"),void l.each(t.split(","),function(e){var t=n.getElementRule(e);t&&(t.attributes.align||(t.attributes.align={},t.attributesOrder.push("align")))});var e,t,i,n})};e.add("legacyoutput",function(e){a(e)}),function c(){}}();
