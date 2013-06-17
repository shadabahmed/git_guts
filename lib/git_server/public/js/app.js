var Utils = (function(){
    var exports = {};
    exports.setMinBodyHeight = function($ele){
        var eleHeight = $ele.offset().top + $ele.height() + 20,
            bodyHeight = $('body').height();
        if(eleHeight > bodyHeight)
            $('.container .commits').css('min-height', eleHeight);
    };
    return exports;
}());

var CommitDetails = (function(){
    var exports = {};
    var resetDescription = function($commit){
        $commit.find('.arrow').show();
        $commit.find('.detail').show().css({top: -1*($commit.outerHeight())/2, width: ''});
        hideWait($commit);
    };

    var zoomDescription = function($commit){
        var $detail = $commit.find('.detail'),
            $arrow = $commit.find('.arrow'),
            width = $('.objects').innerWidth();
        CommitDetails.hideExcept($commit);
        $commit.addClass('selected');
        $arrow.show();
        $detail.show().animate({width: width});
        $('html, body').animate({
            scrollTop: $detail.offset().top - 20
        });
    }
    var resetAll = function () {
        DiffDetails.hideExcept();
        $('li.commit').each(function () {
            resetDescription($(this));
        });
    }
    var showWait = function($commit){
        var $detail = $commit.find('.detail');
        $detail.find('.orig').hide();
        $detail.addClass('wait');
    }
    var hideWait = function($commit){
        var $detail = $commit.find('.detail');
        $detail.find('.orig').show();
        $detail.find('.ajax').empty();
        $detail.removeClass('wait');
    }
    exports.hideExcept = function($commit){
        $('li.commit').not($commit).removeClass('selected').find('.detail, .arrow').fadeOut();
    }
    exports.init = function(){
        $('.commits a.reset').click(function(e){
            e.preventDefault();
            resetAll();
        });
        $('li.commit').each(function(){
            var $commit = $(this);
            resetDescription($commit);
            $commit.on('click', 'a' ,function(e){
                var url = $(this).attr("href"),match;
                e.preventDefault();
                if(match = url.match(/\/commit\/(.*)/)){
                    if(match[1] != $commit.attr('id') && $('#' + match[1]).length)
                    {    $('#' + match[1] + ' > a').trigger('click');
                        return;
                    }
                }
                DiffDetails.hideExcept();
                zoomDescription($commit);
                showWait($commit);
                $commit.find('.ajax').load(url, function(){
                    Utils.setMinBodyHeight($commit.find('.detail'));
                    $commit.find('.detail').removeClass('wait');
                });
            });
        });

    }
    return exports;
}());

var DiffDetails = (function(){
    var exports = {};
    var show = function($diff){
        $diff.find('.arrow').show();
        $diff.find('.detail').addClass('wait').show();
    };
    var zoom = function($diff){
        var $detail = $diff.find('.detail'),
            width = $('.objects').innerWidth();
        Utils.setMinBodyHeight($detail);
        $detail.removeClass('wait');
        $detail.animate({width: width});
        $('html, body').animate({
            scrollTop: $detail.offset().top - 100
        });
    }
    exports.hideExcept = function($diff){
        $('li.diff_container').not($diff).find('.detail, .arrow').fadeOut();
    };
    exports.init = function(){
        $('li.diff_container').each(function(){
            var $diff = $(this),
                $detail = $diff.find('.detail');
            $detail.css({top: -1*($detail.outerHeight() - $diff.outerHeight())/2, width: ''});
            $diff.on('click', 'a', function(e){
                e.preventDefault();
                var url = $(this).attr("href");
                if(match = url.match(/\/commit\/(.*)/)){
                    $('#' + match[1] + ' > a').trigger('click');
                    return;
                }
                DiffDetails.hideExcept($diff);
                CommitDetails.hideExcept();
                show($diff);
                $diff.find('.ajax').load(url, function(){
                    Utils.setMinBodyHeight($diff.find('.detail'));
                    zoom($diff);
                });
            });
        });
    }
    return exports;
}());

// Vertically center align details
$(CommitDetails.init);
$(DiffDetails.init);