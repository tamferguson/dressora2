/* Author: J. Ky Marsh

*/

var coverflow = function() {
      var radius = 20;
      var side = 120;
      var long_side = 200;
      var offset_x = 0;
      var offset_y = 0;
      var pop_x = 0;
      var pop_y = 0;
      var offset = 6;
      var display_offset = 6;
      var queue = [];
      var flipping = false;
      /*
       * creates canvas elements to shape images of regular square 
       */
      function createCanvasElement(img) {
        var canvas = document.createElement('canvas');
        canvas.setAttribute('width',  side);
        canvas.setAttribute('height', side);
        var _height = img.naturalHeight;
        var _width  = img.naturalWidth;
        var w = false; // width is shorter?
        if (_height > _width) w = true;
        var sx, sy, sw, sh;
        if (w) {
          var _side = _width;
          sx = 0;
          sy = _height / 2 - _side / 2;
        } else {
          var _side = _height;
          sx = _width / 2 - _side / 2;
          sy = 0;
        }
        sw = _side;
        sh = _side;

        var cx = canvas.getContext('2d');
        cx.beginPath();
        cx.moveTo(radius, 0);
        cx.lineTo(canvas.width - radius, 0);
        cx.quadraticCurveTo(canvas.width, 0, canvas.width, radius);
        cx.lineTo(canvas.width, canvas.height - radius);
        cx.quadraticCurveTo(canvas.width, canvas.height, canvas.width - radius, canvas.height);
        cx.lineTo(radius, canvas.height);
        cx.quadraticCurveTo(0, canvas.height, 0, canvas.height - radius);
        cx.lineTo(0, radius);
        cx.quadraticCurveTo(0, 0, radius, 0);
        cx.clip();
        cx.drawImage(img, sx, sy, sw, sh, 0, 0, side, side);
        $(canvas).click(coverflow.popup(img));
        return canvas;
      }
      /*
       * pop flow object from queue and excute flip motion.
       */
      function flip() {
        var flow = queue.shift();
        if (!flow) {
          flipping = false;
          return;
        }
        flipping = true;
		
		if (flow.vector== -1 ){
			//move current class to the object on the right
			var next = $('.current').next();			
			if (next){
				$(".current").removeClass("current");
				next.addClass("current");
			}
			
		}
		else {
			//move current class to the object on the left
			var prev = $('.current').prev();			
			if (prev){
				$(".current").removeClass("current");
				prev.addClass("current");
			}
		}

        var _offset = display_offset + flow.vector;
        var speed = 0.05;
        if (queue.length < 4) speed = 0.1;
        if (queue.length < 2) speed = 0.2;
        $('li.img').css('webkitTransition', 'all '+speed+'s ease-in-out');
        var canvas = $('#coverflow li');
        $('#coverflow li').each(function(index) {
		  var addCurrentClass = $(this).hasClass('current');
          var order = index + _offset;
          if (order <= 0) {
            $(this).attr('class', 'img coverflow0');
          } else if (order > 11) {
            $(this).attr('class', 'img coverflow12');
          } else {
            $(this).attr('class', 'img coverflow'+(order));
          }
		  if(addCurrentClass) {
		  	$(this).addClass('current');
		  }
        })
        display_offset = _offset;
        setTimeout(flip, speed * 1000 + 30);
      }
      /*
       * create flow object and push into queue
       */
      function slide(diff) {
        return function() {
          var _offset = offset + diff;
          if (_offset > 6 || _offset < (($('#coverflow li').length - 7) * -1)) return false;
          coverflow.move(diff * -1);
          offset = _offset;
          $('#range').val(_offset * -1);
          if (!flipping) flip();
        }
      }
      return {
        /*
         * initialization
         */
        init: function() {
          $('#dummy img').each(function(index) {
			var itemId = $(this).data('item-id');
            var canvas = createCanvasElement(this);
            var li = $('<li class="img" data-index="' + index + '" data-item-id= "' + itemId +'"/>');
            var order = index + 6;
            if (order <= 11) {
              li.addClass('coverflow'+order);
            } else {
              li.addClass('coverflow12');
            }
			if (index == 0){
				li.addClass('current');
			}
	
			li.click(function(){
				console.log($(this).data('item-id'));
			});
            $('#coverflow').append(li.append(canvas));
          });
          $('#left').click(slide(1));
          $('#right').click(slide(-1));
          $('#range').change(function() {
            var range = $(this).val();
            coverflow.move(parseInt(range) + offset);
            offset = range * -1;
            if (!flipping) flip();
          });
          $(window).keydown(function(e) {
            if (e.keyCode === 27) coverflow.popdown();
            if (e.keyCode === 39) slide(-1)();
            if (e.keyCode === 37) slide(1)();
          });
          $('#zoom_container').css('left', $('#container').css('margin-left'));
        },
        /*
         * show popup image
         */
        popup: function(img) {
          return function() {
            var _height = img.naturalHeight;
            var _width  = img.naturalWidth;
            var w = false; // width is shorter?
            if (_height > _width) w = true;
            var sx, sy, sw, sh;
            if (w) {
              sh = long_side;
              sw = long_side / _height * _width;
            } else {
              sh = long_side / _width * _height;
              sw = long_side;
            }

            var _img = $('<img/>');
            _img.attr('src', img.src);
            _img.attr('width', sw);
            _img.attr('height', sh);
            _img.attr('id', 'zoom');
            _img.css('margin', (((long_side/2)-sh)/2)+'px '+((985-sw)/2)+'px');
            _img.css('-webkit-opacity', 0);
            _img.click(function() {
              coverflow.popdown();
            });
            $('#zoom_container').show().append(_img);
            setTimeout(function() {_img.css('-webkit-opacity', 1);}, 10);
          }
        },
        /*
         * hide popup image
         */
        popdown: function() {
          $('#zoom').css('-webkit-opacity', 0);
          setTimeout(function() {
            $('#zoom').remove();
            $('#zoom_container').hide();
          }, 500);
        },
        /*
         * creates multiple flow objects by range movement and push into queue
         */
        move: function(diff) {
          coverflow.popdown();
          var abs = diff < 0 ? diff * -1 : diff;
          var vector = 1;
          if (diff > 0) vector = -1;
          for (var i = 0; i < abs; i++) {
            var flow = {'vector': vector, 'speed': 0.03}
            queue.push(flow);
          }
          return true;
        }
      }
    }();
	
	$("#save_outfit").click(function(){
		alert("About to save outfit...");
		var topId = $(".top .current").data("item-id");
		alert("with topId = " + topId);
		$.ajax({
	      type: "POST",
		  url: "/outfits",
		  context: document.body,
		  data: {
			top_id: topId
		  },
		  dataType: 'json',
		  success: function(){
		    // stuff that happens after saving
		  }
		});
	})


	$.ajaxSetup({
	  beforeSend: function(xhr) {
	    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
	  }
	});



