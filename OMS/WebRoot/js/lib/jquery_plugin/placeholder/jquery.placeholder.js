/*https://gist.github.com/terkel/1236496/stars*/
(function ($) {

    $(function () {
        if (!supportsInputAttribute('placeholder')) {
            $('[placeholder]').each(function () {
                var $this = $(this),
                    $form = $this.closest('form'),
                    placeholderText = $this.attr('placeholder'),
                    placeholderColor = 'GrayText',
                    defaultColor = $this.css('color');
                $this.bind({
                    focus: function () {
                        if ($this.val() === placeholderText) {
                            $this.val('').css('color', defaultColor);
                        }
                    },
                    blur: function () {
                        if ($this.val() === '') {
                            $this.val(placeholderText).css('color', placeholderColor);
                        } else if ($this.val() === placeholderText) {
                            $this.css('color', placeholderColor);
                        }
                    }
                });
                $this.trigger('blur');
                $form.submit(function () {
                    if ($this.val() === placeholderText) {
                        $this.val('');
                    }
                });
            });
        }
    });

    // detect support for input attirbute
    function supportsInputAttribute (attr) {
        var input = document.createElement('input');
        return attr in input;
    }

})(jQuery);
