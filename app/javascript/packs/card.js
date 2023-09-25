var payjp = null; 
document.addEventListener('DOMContentLoaded', function() { 
    var cardForm = document.querySelector('#card_form');
    if (cardForm) {
        	
        /** 現在ページを更新 */
        if (!payjp) {
          payjp = Payjp('pk_test_6e12b67dda6c33c97a8b391a');
        }

        var elements = payjp.elements();
        var numberElement = elements.create('cardNumber', {placeholder: ""});
        var expiryElement = elements.create('cardExpiry', {placeholder: "月/年"});
        var cvcElement = elements.create('cardCvc', {placeholder: "例：123"});
        
        // elementをDOM上に配置
        numberElement.mount('#number-form');
        expiryElement.mount('#expiry-form');
        cvcElement.mount('#cvc-form');

        $("#info_submit").click(function (e) {
            e.preventDefault();

            var cardholderName = $("#card_form #cardholder_name").val();
        
            payjp.createToken(numberElement, {card: {name: cardholderName}}).then(function (r) {
            if (r.error) {  //  通信に失敗したとき
                alert(r.error.message)
                regist_card.prop('disabled', false)
            } else {
                $("#card_token").append(
                `<input type="hidden" name="token_id" value=${r.id}>
                <input type="hidden" name="card_token" value=${r.card.id}>`
                );
                $('#card_form')[0].submit();
                alert("登録が完了しました");
    
                $("#card_number").removeAttr("name");
                $("#cvc-from").removeAttr("name");
                $("#exp_month").removeAttr("name");
                $("#exp_year").removeAttr("name");
            };
            });
        }); 
    }
});
