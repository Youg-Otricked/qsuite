  QSuite Docs body { font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; margin: 0; padding: 40px; line-height: 1.6; background: #1e2129; color: #ded8eb; font-size: 18px; } main { padding-right: 280px; } h1, h2, h3 { color: #fefafe; } pre { font-family: "JetBrains Mono", "Fira Code", monospace; display: block; width: fit-content; max-width: 100%; background: #272a35; color: #e7dff5; border: none; border-radius: 8px; padding: 1rem; overflow-x: auto; font-size: 16px; } code { color: #fefefe; } table { border-collapse: collapse; margin: 1rem 0; background: #1e2129; } th { background: #1e2129; } td, th { border: 1px solid #352c46; padding: 10px; } hr { border: none; border-top: 1px solid #352c46; margin: 3rem 0; } nav { border-left: 1px solid #352c46; position: fixed; top: 0; right: 0; width: 220px; height: 100vh; display: flex; flex-direction: column; align-items: flex-end; padding: 40px 20px; background: #1e2129; } nav a { text-decoration: none; color: #b9aecf; padding: 0.35rem 0.6rem; border-radius: 6px; font-size: 16px; transition: 0.15s ease; } nav a:hover { color: #ffffff; background: #302544; }

[Getting Started](#getting-started) [Assertions](#assertions) [Exceptions](#exceptions) [Examples](#examples)

QSuite
======

QSuite is a lightweight testing framework for QuantumC. It provides simple assertions, exception testing, colored output, and automatic timing.

* * *

Getting Started
---------------

    #include<qsuite, qsuite@/lib/core.qc> // Assumes that you have the package installed from the registry on the package manager
    qsuite::Suite::Suite suite(qsuite::Suite::Settings{ColorMode.Always, max_ms = 100});
    suite(fn(qsuite::Test::Test t) {
        t.expect(1 + 1, "addition").toBe(2);
    }, "Math Tests");
    

Produces output similar to:

    Math Tests
        addition
            PASS
    Summary:
        1 passed
        0 failed
        Elapsed time: 0 ms
    Overall: PASS
    

* * *

lib/core.qc
===========

Creating a Test Suite
---------------------

    qsuite::Suite::Suite suite({
        .color_mode = ColorMode.Always,
        .max_ms = 250
    });
    

Setting

Description

`color_mode`

Enable or disable ANSI colors.

`max_ms`

Warn if the test run exceeds this time. (Double, Milliseconds)

* * *

Assertions
----------

### Equality

    t.expect(answer, "returns 42")
        .toBe(42);
    

### Not Equal

    t.expect(value, "not zero")
        .toNotBe(0);
    

### Greater Than

    t.expect(score, "positive score")
        .toBeGreaterThan(0);
    

### Less Than

    t.expect(speed, "below limit")
        .toBeLessThan(100);
    

### At Least

    t.expect(count, "minimum count")
        .toBeAtLeast(10);
    

### At Most

    t.expect(level, "maximum level")
        .toBeAtMost(5);
    

### Approximate Equality

    t.expect(pi)
        .toBeAround(3.14159);
    

Or specify your own tolerance:

    t.expect(result)
        .toBeAround(10.0, 0.5);
    

* * *

Exception Testing
-----------------

Expect an exception:

    t.throws(fn() {
        dangerousFunction();
    }, "throws on invalid input");
    

Expect no exception:

    t.doesntThrow(fn() {
        safeFunction();
    }, "runs successfully");
    

* * *

Manual Logging
--------------

Sometimes an assertion isn't enough.

    if (condition) {
        t.logPass("configuration loaded");
    } else {
        t.logFail("configuration missing");
    }
    

* * *

Example
-------

    ...
    suite(fn(qsuite::Test::Test t) {
        t.expect(5 * 5, "multiplication")
            .toBe(25);
        t.expect(10)
            .toBeGreaterThan(5);
        t.expect(3.1415)
            .toBeAround(3.14, 0.01);
        t.throws(fn() {
            throw "error";
        }, "throws correctly");
    
    }, "Example Tests");
    

* * *

Available Assertions
--------------------

Method

Description

`toBe()`

Equality

`toNotBe()`

Inequality

`toBeGreaterThan()`

Greater than

`toBeLessThan()`

Less than

`toBeAtLeast()`

Greater than or equal

`toBeAtMost()`

Less than or equal

`toBeAround()`

Approximate equality

`throws()`

Function should throw

`doesntThrow()`

Function should not throw

`logPass()`

Record a passing check

`logFail()`

Record a failing check

* * *

lib/runner.qc
=============

Runner really only has one thing in it. It runs all the .test.qc files in your directory. So a example runner file would be:

    namespace Exported {
        #include<qsuite, qsuite@/lib/runner.qc>
    }
    int main() {
        return qsuite::Runner::runTests();
    }
