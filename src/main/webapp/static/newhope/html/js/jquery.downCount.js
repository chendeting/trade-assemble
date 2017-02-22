/**
 * downCount: Simple Countdown clock with offset
 * Author: Sonny T. <hi@sonnyt.com>, sonnyt.com
 */

(function ($) {

    $.fn.downCount = function (options, callback) {
    	//debugger;
        var settings = $.extend({
                nowDate: null,
                targetDate:null,
                offset: null,
                needStr:false,
            }, options);

        // Throw error if date is not set
        if (!settings.nowDate) {
            $.error('nowDate is not defined.');
        }

        // Throw error if nowDate or targetDate is set incorectly
        if (!Date.parse(settings.nowDate) || !Date.parse(settings.targetDate)) {
            $.error('Incorrect nowDate or targetDate format, it should look like this, 12/24/2012 12:00:00.');
        }

        // Save container
        var container = this;

        /**
         * Change client's local date to match offset timezone
         * @return {Object} Fixed Date object.
         */
        var currentDate = function () {
            // get client's current date
            var date = new Date(settings.nowDate);

            // turn date to utc
            var utc = date.getTime() + (date.getTimezoneOffset() * 60000);

            // set new Date object
            var new_date = new Date(utc + (3600000*settings.offset));

            return new_date;
        };

        /**
         * Main downCount function that calculates everything
         */
        function countdown () {
            var target_date = new Date(settings.targetDate), // set target date
                current_date = currentDate(); // get fixed current date
            settings.nowDate = new Date(new Date(settings.nowDate).getTime()+1000);

            // difference of dates
            var difference = target_date - current_date;

            // if difference is negative than it's pass the target date
            if (difference < 0) {
            	if (interval == undefined || interval == "undefined"){
            		if (callback && typeof callback === 'function'){
            			setTimeout( callback, 1000 );
            		} 
            		return;
            	} else {
            		// stop timer
	                clearInterval(interval);
	
	                if (callback && typeof callback === 'function') callback();
	
	                return;
            	}
            }

            // basic math variables
            var _second = 1000,
                _minute = _second * 60,
                _hour = _minute * 60,
                _day = _hour * 24;

            // calculate dates
            var days = Math.floor(difference / _day),
                hours = Math.floor((difference % _day) / _hour),
                minutes = Math.floor((difference % _hour) / _minute),
                seconds = Math.floor((difference % _minute) / _second);

                // fix dates so that it will show two digets
                days = (String(days).length >= 2) ? days : '0' + days;
                hours = (String(hours+days*24).length >= 2) ? hours+days*24:'0'+(hours+days*24);
                minutes = (String(minutes).length >= 2) ? minutes : '0' + minutes;
                seconds = (String(seconds).length >= 2) ? seconds : '0' + seconds;
            // based on the date change the refrence wording
            var ref_days = (days === 1) ? 'day' : 'days',
                ref_hours = (hours === 1) ? 'hour' : 'hours',
                ref_minutes = (minutes === 1) ? 'minute' : 'minutes',
                ref_seconds = (seconds === 1) ? 'second' : 'seconds';

            // set to DOM
            container.find('.days').text(days);
            container.find('.hours').text(hours);
            container.find('.minutes').text(minutes);
            container.find('.seconds').text(seconds);

            container.find('.days_ref').text(ref_days);
            container.find('.hours_ref').text(ref_hours);
            container.find('.minutes_ref').text(ref_minutes);
            container.find('.seconds_ref').text(ref_seconds);
            if (settings.needStr){
            	container.text(hours+":"+minutes+":"+seconds);
            }
        };
        
        countdown();
        
        // start
        var interval = setInterval(countdown, 1000);
    };

})(jQuery);