Fractal.hs
----------

Generate [fractal][fractal] images by escape time method, currently it can generate [Mandelbrot set][mandelbrot], [Julia set][julia], [Burning Ship fractal][ship], [Nova fractal][nova].


usage
-----

It can run as a script or compile and run.

```
# run as haskell script
chmod +x Fractal.hs
./Fractal.hs ...

# compile and run
ghc --make Fractal.hs -o fractal
./fractal ...
```

`fractal mandelbrot` may generate [Mandelbrot set][mandelbrot]. 
run `fractal help` to see more.


screenshots
-----------

[click me!](./screenshots)

todo
----

* Support more cmdline args.

* Make it colorful.

* There are much more generating methods according to [wikipedia][fractal], add more besides `Escape.hs`.

* Study more about fractal, what is it.


about
-----

This small program is written for haskell learning purpose. Feel free to contribute, any advice, issue or pr is welcom.


[fractal]: http://en.wikipedia.org/wiki/Fractal
[mandelbrot]: http://en.wikipedia.org/wiki/Mandelbrot_set
[julia]: http://en.wikipedia.org/wiki/Julia_set
[ship]: http://en.wikipedia.org/wiki/Burning_Ship_fractal
[nova]: http://en.wikipedia.org/wiki/Nova_fractal
