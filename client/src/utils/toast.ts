const floatToast = (className: string): void => {
  const toastMsg: Element = document.querySelector(className)!;

  if (!toastMsg.classList.contains('reveal')) {
    setTimeout(() => {
      document.querySelector(className)!.classList.remove('reveal');
    }, 1000);
  }

  toastMsg.classList.add('reveal');
};

export default floatToast;
