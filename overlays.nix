final: prev: {
  mutter = prev.mutter.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      ./patches/0001-cogl-Fix-possible-null-error-return-in-set_egl_error.patch
    ];
  });
}
