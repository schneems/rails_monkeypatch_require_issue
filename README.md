## Reproduce Require Monkeypatch Issue

I'm running into an issue on derailed when trying to monkeypatch `Kernel.require` https://github.com/schneems/derailed_benchmarks/issues/149.

I've reproduced the issue without derailed. I think the issue is related to https://github.com/rails/rails/blob/192df82f0d96db48a080fc71ef203979f30b4d08/activesupport/lib/active_support/dependencies.rb#L238-L244.

You can run the repro script like this:

```
bundle install
bundle exec ruby main.rb
```

Correct behavior desired:

```
$ bundle exec ruby main.rb
config.eager_load is set to nil. Please update your config/environments/*.rb files accordingly:

  * development - set it to false
  * test - set it to false (unless you use a tool that preloads your test environment)
  * production - set it to true

require
Worked AS EXPECTED !!!!!!!!!
```

What you will actually see:

```
$ be ruby main.rb
config.eager_load is set to nil. Please update your config/environments/*.rb files accordingly:

  * development - set it to false
  * test - set it to false (unless you use a tool that preloads your test environment)
  * production - set it to true

Traceback (most recent call last):
main.rb:47:in `<main>': Did not work, expected an exception from our monkeypatch (RuntimeError)
```

## Script

The top of main.rb is the simplest possible rails 6 app I could come up with that reproduces the issue.

The bottom patches Kernel.require and a few other methods so they should raise an error instead (if you call them, you'll know). Finally we call

```
require 'rake'
```

Which should trigger the monkeypatch. If you remove the rails code, then it works, if you add it back in it fails.
