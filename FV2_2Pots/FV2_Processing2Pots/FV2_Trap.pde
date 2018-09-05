void trap() {                    //Trap the EyeBall (method)
    if (x < 0 + penSize) {
      x = 0 + penSize;
    }else if (x > width - penSize) {
      x = width - penSize;
    }
    if (y < 0 + penSize) {
      y = 0 + penSize;
    }else if (y > height - penSize) {
      y = height - penSize;
    }
  }
