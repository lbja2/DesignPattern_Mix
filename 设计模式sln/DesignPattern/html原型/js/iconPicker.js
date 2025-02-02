/*
 * Bootstrap 3.3.6 IconPicker - jQuery plugin for Icon selection
 *
 * Copyright (c) 20013 A. K. M. Rezaul Karim<titosust@gmail.com>
 * Modifications (c) 20015 Paden Clayton<fasttracksites.com>
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Project home:
 *   https://github.com/titosust/Bootstrap-icon-picker
 *
 * Version:  1.0.1
 *
 */

(function($) {

    $.fn.iconPicker = function( options ) {
        
        var mouseOver=false;
        var $popup=null;
        var icons=new Array("test12","adjust","alert","align-center","align-justify","align-left","align-right","apple","arrow-down","arrow-left","arrow-right","arrow-up","asterisk","baby-formula","backward","ban-circle","barcode","bed","bell","bishop","bitcoin","blackboard","bold","book","bookmark","briefcase","btc","bullhorn","calendar","camera","cd","certificate","check","chevron-down","chevron-left","chevron-right","chevron-up","circle-arrow-down","circle-arrow-left","circle-arrow-right","circle-arrow-up","cloud","cloud-download","cloud-upload","cog","collapse-down","collapse-up","comment","compressed","console","copy","copyright-mark","credit-card","cutlery","dashboard","download","download-alt","duplicate","earphone","edit","education","eject","envelope","equalizer","erase","eur","euro","exclamation-sign","expand","export","eye-close","eye-open","facetime-video","fast-backward","fast-forward","file","film","filter","fire","flag","flash","floppy-disk","floppy-open","floppy-remove","floppy-save","floppy-saved","folder-close","folder-open","font","forward","fullscreen","gbp","gift","glass","globe","grain","hand-down","hand-left","hand-right","hand-up","hd-video","hdd","header","headphones","heart","heart-empty","home","hourglass","ice-lolly","ice-lolly-tasted","import","inbox","indent-left","indent-right","info-sign","italic","jpy","king","knight","lamp","leaf","level-up","link","list","list-alt","lock","log-in","log-out","magnet","map-marker","menu-down","menu-hamburger","menu-left","menu-right","menu-up","minus","minus-sign","modal-window","move","music","new-window","object-align-bottom","object-align-horizontal","object-align-left","object-align-right","object-align-top","object-align-vertical","off","oil","ok","ok-circle","ok-sign","open","open-file","option-horizontal","option-vertical","paperclip","paste","pause","pawn","pencil","phone","phone-alt","picture","piggy-bank","plane","play","play-circle","plus","plus-sign","print","pushpin","qrcode","queen","question-sign","random","record","refresh","registration-mark","remove","remove-circle","remove-sign","repeat","resize-full","resize-horizontal","resize-small","resize-vertical","retweet","road","rub","ruble","save","save-file","saved","scale","scissors","screenshot","sd-video","search","send","share","share-alt","shopping-cart","signal","sort","sort-by-alphabet","sort-by-alphabet-alt","sort-by-attributes","sort-by-attributes-alt","sort-by-order","sort-by-order-alt","sound-5-1","sound-6-1","sound-7-1","sound-dolby","sound-stereo","star","star-empty","stats","step-backward","step-forward","stop","subscript","subtitles","sunglasses","superscript","tag","tags","tasks","tent","text-background","text-color","text-height","text-size","text-width","th","th-large","th-list","thumbs-down","thumbs-up","time","tint","tower","transfer","trash","tree-conifer","tree-deciduous","triangle-bottom","triangle-left","triangle-right","triangle-top","unchecked","upload","usd","user","volume-down","volume-off","volume-up","warning-sign","wrench","xbt","yen","zoom-in","zoom-out");
        var settings = $.extend({
        	
        }, options);
        return this.each( function() {
        	element=this;
            if(!settings.buttonOnly && $(this).data("iconPicker")==undefined ){
            	$this=$(this).addClass("form-control");
            	$wraper=$("<div/>",{class:"input-group"});
            	$this.wrap($wraper);

            	$button=$("<span class=\"input-group-addon pointer\"><i class=\"glyphicon  glyphicon-picture\"></i></span>");
            	$this.after($button);
            	(function(ele){
	            	$button.click(function(){
			       		createUI(ele);
			       		showList(ele,icons);
	            	});
	            })($this);

            	$(this).data("iconPicker",{attached:true});
            }
        
	        function createUI($element){
	        	$popup=$('<div/>',{
	        		css: {
		        		'top':$element.offset().top+$element.outerHeight()+6,
		        		'left': $element.offset().left,
		        		'z-index': 1111111
		        	},
		        	class:'icon-popup'
	        	})

	        	$popup.html('<div class="ip-control"> \
						          <ul> \
						            <li><a href="javascript:;" class="btn" data-dir="-1"><span class="glyphicon  glyphicon-fast-backward"></span></a></li> \
						            <li><input type="text" class="ip-search glyphicon  glyphicon-search" placeholder="Search" /></li> \
						            <li><a href="javascript:;"  class="btn" data-dir="1"><span class="glyphicon  glyphicon-fast-forward"></span></a></li> \
						          </ul> \
						      </div> \
						     <div class="icon-list"> </div> \
					         ').appendTo("body");
	        	
	        	
	        	$popup.addClass('dropdown-menu').show();
				$popup.mouseenter(function() {  mouseOver=true;  }).mouseleave(function() { mouseOver=false;  });

	        	var lastVal="", start_index=0,per_page=30,end_index=start_index+per_page;
	        	$(".ip-control .btn",$popup).click(function(e){
	                e.stopPropagation();
	                var dir=$(this).attr("data-dir");
	                start_index=start_index+per_page*dir;
	                start_index=start_index<0?0:start_index;
	                if(start_index+per_page<=210){
	                  $.each($(".icon-list>ul li"),function(i){
	                      if(i>=start_index && i<start_index+per_page){
	                         $(this).show();
	                      }else{
	                        $(this).hide();
	                      }
	                  });
	                }else{
	                  start_index=180;
	                }
	            });
	        	
	        	$('.ip-control .ip-search',$popup).on("keyup",function(e){
	                if(lastVal!=$(this).val()){
	                    lastVal=$(this).val();
	                    if(lastVal==""){
	                    	showList(icons);
	                    }else{
	                    	showList($element, $(icons)
							        .map(function(i,v){ 
								            if(v.toLowerCase().indexOf(lastVal.toLowerCase())!=-1){return v} 
								        }).get());
						}
	                    
	                }
	            });  
	        	$(document).mouseup(function (e){
				    if (!$popup.is(e.target) && $popup.has(e.target).length === 0) {
				        removeInstance();
				    }
				});

	        }
	        function removeInstance(){
	        	$(".icon-popup").remove();
	        }
	        function showList($element,arrLis){
	        	$ul=$("<ul>");
	        	
	        	for (var i in arrLis) {
	        		$ul.append("<li><a href=\"#\" title="+arrLis[i]+"><span class=\"glyphicon  glyphicon-"+arrLis[i]+"\"></span></a></li>");
	        	};

	        	$(".icon-list",$popup).html($ul);
	        	$(".icon-list li a",$popup).click(function(e){
	        		e.preventDefault();
	        		var title=$(this).attr("title");
	        		$element.val("glyphicon glyphicon-"+title);
	        		removeInstance();
	        	});
	        }

        });
    }

}(jQuery));
