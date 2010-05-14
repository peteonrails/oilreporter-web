
var $j = jQuery.noConflict();

$j(function() {

	// comment next lines to disable features

	lightBox(); // initialize & configure lightbox script

	navigation(); // dynamic light selection in the menu (windows7-like)

	startTimers(); // start slidefader & newsticker timers

	if ($j("form#contact").length > 0) contactForm(); // initialize javascript validators for the contact form

	if ($j("#reports").length > 0) reports(500, 0.6); // reports sleek image shade (timer, opacity)

	if ($j("div.item p.tags a", "#reports").length > 0) reportsFilter(); // reports item filter

});

// Timers

var faderId, newstickerId;

function startTimers() {

	if ($j("#slides img").length > 1) {
		faderId = setInterval("slides()", 5000); // slide timer (5000 ms = 5 sec)
	}

	if ($j("#newsline").length > 0) {
		newstickerId = setInterval("newsline()", 4000); // newsticker timer
	}
}

function stopTimers() {

	if (faderId) clearInterval(faderId); // clear slide fader timer
	if (newstickerId) clearInterval(newstickerId); // clear newsticker timer

}

// functions

function contactForm() {

	$j(".input", "form#contact").blur(function() { validateInput($j(this)); }); // validate when unfocus

	$j("#submit", "form#contact").click(function() { // validate on submit
		$j(".input", "form#contact").each(function() { validateInput($j(this)); })
		if (!isFormValid())
			return false;
	});

}

function isFormValid() {

	return $j(".input.incorrect", "form#contact").length > 0 ? false : true;

}

function validateInput(obj) {

	var id = obj.attr("id");
	var correct = false;

	if (id == "email") { // validate email
		if (obj.val().match(/^[a-zA-Z0-9_\.\-]+\@([a-zA-Z0-9\-]+\.)+[a-zA-Z0-9]{2,4}$/))
			correct = true;
	}
	else if (id == "contact") { // validate everything else
		if (obj.val().replace(/(^\s+)|(\s+$)/g, "") != "")
			correct = true;
			
	}

	obj.removeClass("correct incorrect"); // clearing
	if (correct) {
		obj.addClass("correct");
	}
	else {
		obj.addClass("incorrect");
	}

}

//

function navigation() {
	$j("li a", "#nav").
		mousemove(function(e) {
			var relativeY = (e.pageY - this.offsetTop - 45) / 4;
			$j(this).css("backgroundPosition", "center " + relativeY + "px");
		}).
		mouseout(function(e) {
			$j(this).css("backgroundPosition", "center center");
		});
}

//

function lightBox() {
	$j("a[rel^='lightbox']").prettyPhoto({
		animationSpeed: 'fast', /* fast/slow/normal */
		padding: 40, /* padding for each side of the picture */
		opacity: 0.5, /* Value betwee 0 and 1 */
		showTitle: true, /* true/false */
		allowresize: true, /* true/false */
		counter_separator_label: '/', /* The separator for the gallery counter 1 "of" 2 */
		theme: 'dark_rounded', /* light_rounded / dark_rounded / light_square / dark_square */
		hideflash: false, /* Hides all the flash object on a page, set to TRUE if flash appears over prettyPhoto */
		modal: false, /* If set to true, only the close button will close the window */
		changepicturecallback: function() { stopTimers(); },
		callback: function() { startTimers(); }
	});
}

//

function reports(time, opacity) {
	$j("img", "#reports")
		.css("opacity", 1)
		.hover(
			function() {
				$j(this).stop().animate({ opacity: opacity }, time);
			},
			function() {
				$j(this).stop().animate({ opacity: 1 }, time);
			}
		);
}

function reportsFilter() {
	var tags = getAllTags();
	var ph = $j(".placeholder", "#filter");
	$j(tags).each(function(i, tag) {
		ph.append(', <a href="#">' + tag + '</a>');
	});

	$j(".placeholder a", "#filter").click(function() {

		$j(".placeholder a.active", "#filter").removeClass("active");
		$j(this).addClass("active");

		reportsClick($j(this));
		return false;
	});

	$j("#filter", "#reports").show();

	// select by the #hash in the url
	var hash = trim(window.location.hash.substring(1));
	if (hash.length > 0) {
		$j(".placeholder a:contains('" + hash + "'):first", "#filter").click();
	}
}

{ // reportsFilter functions:

	function reportsClick(obj) {
		var tag = obj.text();
		var rel = obj.attr("rel");

		reportsHideAll();

		if (rel == "Start")
			reportsShow();
		else
			reportsShow(tag);

		reportsClearer();
	}

	function reportsClearer() {
		var visibleItems = $j("div.item:visible", "#reports");
		var lastIndex = visibleItems.length - 1;
		visibleItems.each(function(i, item) {
			if (i % 3 == 2 && i != lastIndex) $j('<div class="clear"> </div>').insertAfter(item);
		});
	}

	function reportsShow(tag) {
		if (tag)
			$j("div.item:has(p.tags a:contains('" + tag + "'))", "#reports").show();
		else
			$j("div.item", "#reports").show();
	}

	function reportsHideAll() {
		$j("div.item", "#reports").hide();
		$j("#reports > div.clear:not(:last)").remove();
	}

	function getAllTags() {
		var tags = [];
		$j("div.item p.tags a", "#reports").each(function() { tags.push(trim($j(this).text())); });
		return tags.unique().sort();
	}

}

//

function slides() {

	if (ie6) {
		return; // ie6 fails to animate overall opacity of the transparent PNGs
	}

	var $active = $j("#slides img.active");

	if ($active.length == 0) {
		$active = $j("#slides img:last");
	}

	var $next = $active.next().length ?
			$active.next() :
			$j("#slides img:first");

	$active.addClass("pre-active");

	$next.
		css({ opacity: 0 }).
		addClass("active").
		animate({ opacity: 1 }, 1000, function() {
			$active.
				removeClass("active pre-active").
				css({ opacity: 0 });
		});

}

//

function newsline() {
	var $ph = $j("#newsline a.ph");

	if ($ph.length == 0) { // prepare basement
		var $first = $j("#newsline a:first");
		$j("#newsline p").append("<br />").append($first.clone());
		$ph = $first.addClass("ph");
	}

	var $active = $j("#newsline a.active");

	if ($active.length == 0) {
		$active = $j("#newsline a:last");
	}

	var $next = $active.next().next().length ?
			$active.next().next() :
			$j("#newsline a:not(.ph):first");

	$next.addClass("active");
	$active.removeClass("active");

	if (ie6) { // bha! another ie6 opacity fail
		$ph.html($next.html());
		$ph.attr("href", $next.attr("href"));
	}
	else {
		$ph.animate({ opacity: 0 }, 500, function() { // hiding
			$ph.html($next.html());
			$ph.attr("href", $next.attr("href"));
			$ph.animate({ opacity: 1 }, 300); // revealing
		});
	}
}

//

var ie6 = jQuery.browser.msie && parseInt(jQuery.browser.version) < 7;

// JS helpers:

{
	function trim(str) {
		return str.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
	}

	// Array.indexOf( value, begin, strict )
	Array.prototype.indexOf = function(v, b, s) {
		for (var i = +b || 0, l = this.length; i < l; i++) {
			if (this[i] === v || s && this[i] == v) { return i; }
		}
		return -1;
	};
	// Array.unique( strict )
	Array.prototype.unique = function(b) {
		var a = [], i, l = this.length;
		for (i = 0; i < l; i++) {
			if (a.indexOf(this[i], 0, b) < 0) { a.push(this[i]); }
		}
		return a;
	};
	// Array1.intersect( Array2 )
	Array.prototype.intersect = function(b) {
		var as, al, a = [];
		if (b.length < this.length) { as = b; al = this }
		else { as = this; al = b }
		$j.each(as, function(i, user) {
			if (al.indexOf(user) >= 0)
				a.push(user);
		});
		return a;
	}
}