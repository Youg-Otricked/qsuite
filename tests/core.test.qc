namespace Exported {
    #include<qsuite, "../lib/core.hqc">
}
int main() {
    qsuite::Suite::Suite suite = qsuite::Suite::Suite(qsuite::Suite::Settings{qsuite::ColorMode.Always, 10.0});
    suite(fn(qsuite::Test::Test v) -> void {
        v.expect<int>(1, "expect 1 to be 1").toBe(1);
    }, "Test QSuite");
} 
