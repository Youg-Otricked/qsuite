namespace Exported {
    #include<qsuite, "../lib/core.qc">
}
int main() {
    qsuite::Suite::Suite suite = qsuite::Suite::Suite(qsuite::Suite::Settings{qsuite::ColorMode.Always, 10.0});
    suite(fn(qsuite::Test::Test v) -> void {
        v.throws(fn() -> void{
            throw 1;
        }, "Expect throw to throw");
        v.expect<addr_t>(qsuite::passes, "Expecting 1").toBe(1a);
        v.expect<addr_t>(qsuite::passes, "Expecting 2").toBe(2a);
        v.expect<addr_t>(qsuite::passes, "Expecting 3").toBe(3a);
        v.expect<addr_t>(qsuite::passes, "Expecting 4").toBe(4a);
    }, "Test QSuite");
} 
