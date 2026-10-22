#nomain
struct timespec {
    long int tv_sec;
    long int tv_nsec;
}
foreign:
int clock_gettime(int clock_id, timespec *tp);
:foreign
namespace qsuite {
addr_t passes;
addr_t fails;
const string RESET  = "\033[0m";
const string RED    = "\033[31m";
const string GREEN  = "\033[32m";
const string YELLOW = "\033[33m";
const string CYAN   = "\033[36m";
enum ColorMode {
    Always;
    Never;
}
ColorMode color_mode;
string color(string ansi) {
    return `ternary(color_mode == ColorMode.Always, ansi, "");
}
namespace Values {
    class Value<T> {
        private T value;
        Value(T value) {
            this->value = value;
        }
        void toBeTrue() {
            return this->value == true;
        }
        void toBeFalse() {
            return this->value == false;
        }
        void toBe(T other) {
            if (this->value == other) {
                passes++;
                `qout("%s%s        PASS%s\n", color(RESET), color(GREEN), color(RESET));
            } else {
                fails++;
                `qout("%s%s        FAIL: Expected %a to be %a%s\n", color(RESET), color(RED), other, this->value, color(RESET));
            }
        }
        void toNotBe(T other) {
            if (this->value != other) {
                passes++;
                `qout("%s%s        PASS%s\n", color(RESET), color(GREEN), color(RESET));
            } else {
                fails++;
                `qout("%s%s        FAIL: Expected %a to be %a%s\n", color(RESET), color(RED), other, this->value, color(RESET));
            }
        }
        void toBeGreaterThan(T other) {
            if (this->value > other) {
                passes++;
                `qout("%s%s        PASS%s\n", color(RESET), color(GREEN), color(RESET));
            } else {
                `qout("%s%s        FAIL: Expected %a to be %a%s\n", color(RESET), color(RED), other, this->value, color(RESET));
                fails++;
            }
        }
        void toBeLessThan(T other) {
            if (this->value < other) {
                passes++;
                `qout("%s%s        PASS%s\n", color(RESET), color(GREEN), color(RESET));
            } else {
                `qout("%s%s        FAIL: Expected %a to be %a%s\n", color(RESET), color(RED), other, this->value, color(RESET));
                fails++;
            }
        }
        void toBeAtLeast(T other) {
            if (this->value >= other) {
                passes++;
                `qout("%s%s        PASS%s\n", color(RESET), color(GREEN), color(RESET));
            } else {
                `qout("%s%s        FAIL: Expected %a to be %a%s\n", color(RESET), color(RED), other, this->value, color(RESET));
                fails++;
            }
        }
        void toBeAtMost(T other) {
            if (this->value <= other) {
                passes++;
                `qout("%s%s        PASS%s\n", color(RESET), color(GREEN), color(RESET));
            } else {
                `qout("%s%s        FAIL: Expected %a to be %a%s\n", color(RESET), color(RED), other, this->value, color(RESET));
                fails++;
            }
        }
        void toBeAround(T other, double margin_of_error = 0.01) {
            if (this->value >= other - margin_of_error && this->value <= other + margin_of_error) {
                passes++;
                `qout("%s%s        PASS%s\n", color(RESET), color(GREEN), color(RESET));
            } else {
                `qout("%s%s        FAIL: Expected %a to be %a%s\n", color(RESET), color(RED), other, this->value, color(RESET));
                fails++;
            }
        }
    }
}
namespace Test {
    class Test {
        Test() {
        }
        Values::Value<T> expect<T>(T value, string message) {
            `qout("%s%s    %s%s\n", color(RESET), color(CYAN), message, color(RESET));
            return Values::Value<T>(value);
        }
        void logFail(string message) {
            `qout("%s%s    %s%s\n", color(RESET), color(CYAN), message, color(RESET));
            fails++;
        }
        void logPass(string message) {
            `qout("%s%s    %s%s\n", color(RESET), color(CYAN), message, color(RESET));
            passes++;
        }
        void throws(fn() -> void f, string message) {
            try {
                f();
                this->logFail(message);
                `qout("%s%s        FAIL%s\n", color(RESET), color(RED), color(RESET));
            } catch(...) {
                this->logPass(message);
                `qout("%s%s        PASS%s\n", color(RESET), color(GREEN), color(RESET));
            }
        }
        void doesntThrow(fn() -> void f, string message) {
            try {
                f();
                this->logPass(message);
                `qout("%s%s        PASS%s\n", color(RESET), color(GREEN), color(RESET));
            } catch(...) {
                this->logFail(message);
                `qout("%s%s        FAIL%s\n", color(RESET), color(RED), color(RESET));
            }
        }
    }
}
namespace Suite {
    struct Settings {
        ColorMode color_mode;
        double max_ms;
    }
    class Suite { 
        double max_ms;
        Suite(Settings settings) {
            passes = 0;
            fails = 0;
            color_mode = settings.color_mode;
            this->max_ms = settings.max_ms;
        }
        void operator( )(fn(Test::Test) -> void t, string descriptor) {
            timespec start = timespec{};
            timespec end = timespec{};
            `qout("%s\n", descriptor);
            clock_gettime(1, &start);
            t(Test::Test());
            clock_gettime(1, &end);
            double elapsed_ms = ((end.tv_sec - start.tv_sec) * 1000000000 + (end.tv_nsec - start.tv_nsec)) / 1000000.0;
            `qout("%s%sSummary:\n", color(RESET), color(CYAN));
            `qout("    %i passed\n", passes);
            `qout("    %i failed\n", fails);
            `qout("    Elapsed time: %d ms\n", elapsed_ms);
            if (elapsed_ms > this->max_ms) {
                `qout("%sWARNING: Elapsed time was %d milliseconds over the maximum.%s\n", color(YELLOW), elapsed_ms - this->max_ms, color(RESET));
            }
            `qout("Overall: %s%s\n", `ternary(fails > 0, "FAIL", "PASS"), color(RESET));
        }
    }
}
}
