document.addEventListener("turbo:load", function() {
  // DOM 要素を取得
const yearSelectElm = document.querySelector('[name="user[birthday(1i)]"]');
const monthSelectElm = document.querySelector('[name="user[birthday(2i)]"]');
const daySelectElm = document.querySelector('[name="user[birthday(3i)]"]');

// 日付を更新する関数
function updateDaySelect() {
  const month = parseInt(monthSelectElm.value, 10);
  const year = parseInt(yearSelectElm.value, 10);

  if (!isNaN(month) && !isNaN(year)) {
    const daysInMonth = new Date(year, month, 0).getDate();

    // 選択肢を更新
    for (let i = daySelectElm.options.length - 1; i >= daysInMonth; i--) {
      daySelectElm.remove(i);
    }
    for (let i = daySelectElm.options.length; i <= daysInMonth; i++) {
      const option = document.createElement('option');
      option.value = i;
      option.text = i;
      daySelectElm.add(option);
    }
  }
}

// DOM 要素が存在する場合、日付を更新する
if (yearSelectElm && monthSelectElm && daySelectElm) {
  yearSelectElm.addEventListener('change', updateDaySelect);
  monthSelectElm.addEventListener('change', updateDaySelect);
  updateDaySelect();
}
});























