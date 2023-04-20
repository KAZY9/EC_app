// $(document).on("turbo:load", function(){ 
var payjp = Payjp('pk_test_6e12b67dda6c33c97a8b391a');
document.addEventListener("turbo:load", function() {
    if (document.URL.match('mypage/cards/')) {
    
    var elements = payjp.elements();

    // var numberElement = elements.create('cardNumber');
    // var expiryElement = elements.create('cardExpiry');
    // var cvcElement = elements.create('cardCvc');

    var numberElement = elements.create('cardNumber', {
        style: {
          base: {
            placeholder: ""
          }
        }
      });

      numberElement.update({style: {base: {placeholder: ''}}})
      
      var expiryElement = elements.create('cardExpiry', {
        style: {
          base: {
            placeholder: ""
          }
        }
      });
      
      var cvcElement = elements.create('cardCvc', {
        style: {
          base: {
            placeholder: ""
          }
        }
      });
      


    // elementをDOM上に配置
    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');


    $("#info_submit").click(function (e) {
        e.preventDefault();

        var cardholderName = $("#card_form #cardholder_name").val();
        console.log(cardholderName);
        //ここでトークンを作成　
        // createTokenの引数には任意のElement1つを渡す
        payjp.createToken(numberElement, {card: {name: cardholderName}}).then(function (r) {
          if (r.error) {  //  通信に失敗したとき
            alert(r.error.message)
            regist_card.prop('disabled', false)
          } else {
            alert("登録が完了しました");
            $("#card_token").append(
              `<input type="hidden" name="token_id" value=${r.id}>
              <input type="hidden" name="card_token" value=${r.card.id}>`
            );
            $('#card_form')[0].submit();
            //  ↑↑　ここでtype='hidden'にしてsubmitにtokenを乗せている
  
            $("#card_number").removeAttr("name");
            $("#cvc-from").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name");
            //  ↑↑　ここでremoveAttrで記述を削除してます
          };
        });
    }); 
  }
});

