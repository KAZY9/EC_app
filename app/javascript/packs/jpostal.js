document.addEventListener('DOMContentLoaded', function () {
	$('#user_postal_code').jpostal({
		postcode : [
			'#user_postal_code'
		],
		address: {
		  "#user_prefecture_code"    : "%3", // # 都道府県が入力される
		  "#user_city"               : "%4%5", // # 市区町村と町域が入力される
		  "#user_street_and_others"  : "%6%7" // # 大口事務所の番地と名称が入力される
		}
	});

	$('#address_postal_code').jpostal({
		postcode : [
			'#address_postal_code'
		],
		address: {
		  "#address_prefecture_code"    : "%3", // # 都道府県が入力される
		  "#address_city"               : "%4%5", // # 市区町村と町域が入力される
		  "#address_street_and_others"  : "%6%7" // # 大口事務所の番地と名称が入力される
		}
	});
});
