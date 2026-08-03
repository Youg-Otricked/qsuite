namespace Exported {
    #include<qsuite, "../lib/core.hqc">
}
int main() {
    qsuite::Suite::Suite suite = qsuite::Suite::Suite(qsuite::Suite::Settings{qsuite::ColorMode.Always, 10.0});
    suite(fn(qsuite::Test::Test v) -> void {
        v.throws(fn() -> void{
            throw 1;
        }, "Expect throw to throw");
    }, "Test QSuite");
} 
