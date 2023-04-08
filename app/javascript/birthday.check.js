  const yearSelect = document.querySelector('[name="user[birthday(1i)]"]');
  const monthSelect = document.querySelector('[name="user[birthday(2i)]"]');
  const daySelect = document.querySelector('[name="user[birthday(3i)]"]');

  function limitDays() {
    const month = parseInt(monthSelect.value, 10);
    const year = parseInt(yearSelect.value, 10);
    if (!isNaN(month) && !isNaN(year)) {
      const daysInMonth = new Date(year, month, 0).getDate();
      for (let i = daySelect.options.length - 1; i >= daysInMonth; i--) {
        daySelect.remove(i);
      }
      for (let i = daySelect.options.length; i <= daysInMonth; i++) {
        const option = document.createElement('option');
        option.value = i;
        option.text = i;
        daySelect.add(option);
      }
    }
  }

  yearSelect.addEventListener('change', limitDays);
  monthSelect.addEventListener('change', limitDays);
  

  


















