
window.addEventListener('turbo:load', () => {
  document.addEventListener('submit', (event) => {
    if (event.target && event.target.className === 'delete-alertbox') {
      event.preventDefault();
      Swal.fire({
        title: 'Are you sure you want to delete it?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
      })
      .then((result) => {
        if (result.isConfirmed) {
          document.querySelector('.delete-alertbox').submit();
        }
      })
      .catch(event.preventDefault());
    }
  });
});
