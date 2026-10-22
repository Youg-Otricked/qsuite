#nomain
namespace Exported {
    #include<Vector, std>
}
foreign:
char **environ;
int posix_spawnp(
    int *pid,
    string file,
    void *file_actions,
    void *attributes,
    char **argv,
    char **environment
);
int waitpid(int pid, int *status, int options);
:foreign
namespace qsuite {
namespace Runner {
    long int getdents64(int fd, char *buffer, long int size) {
        long int result;
        `inline(R"(
            mov edi, $1r
            mov rsi, $2r
            mov rdx, $3r
            mov rax, 217
            syscall
            mov $0=r, rax
        )", result, fd, buffer, size, "~{rax,rdi,rsi,rdx,rcx,r11,memory}");
        return result;
    }
    int openat(string path) {
        int result;
        `inline(R"(
            mov rax, 257
            mov rdi, -100
            mov rsi, $1r
            mov rdx, 0x10000
            mov r10, 0
            syscall
            mov $0=r, eax
        )", result, path, "~{rax, rdi, rsi, rdx, rcx, r11, r10, memory}");
        return result;
    } 
    Vector::Vec<string> scanDirectories(string path) {
        Vector::Vec<string> files = [string, 0];
        int dirFd = openat(path);
        if (dirFd < 0) throw "No " + path + " directory found in current directory";
        char[32768] buffer = [char, 32768];
        while (true) {
            long int result = getdents64(dirFd, buffer, 32768);
            if (result == 0) break;
            if (result < 0) throw "Could not read directory " + path;
            long int offset = 0;
            while (offset < result) {
                char *entry = (&(buffer[0])) + offset;
                void *v = entry + 16;
                short int *record = v;
                short int recordLength = *record;
                byte typ = *(entry + 18);
                char *name = entry + 19;
                if (recordLength < 20 || offset + recordLength > result) throw "Malformed directory entry in " + path;
                if (typ == 8 && `endswith(name, ".test.qc")) {
                    files.push(path + "/" + name);
                } else if (name != "." && name != ".."  &&  typ == 4) {
                    Vector::Vec<string> nested = scanDirectories(path + "/" + name);
                    foreach (string file in nested) {
                        files.push(file);
                    }
                }
                offset += recordLength;
            }
        }
        `close(dirFd);
        return files;
    }
    int runTests() {
        Vector::Vec<string> files = scanDirectories("tests");
        bool failed = false;
        foreach (string file in files) {
            `qout("Running test %s\n", file);
            int compilerPid = 0;
            char *compilerArgv[3] = [
                "qc",
                file,
                nullptr
            ];
            int spawnError = posix_spawnp(
                &compilerPid,
                "qc",
                nullptr,
                nullptr,
                compilerArgv,
                environ
            );
            if (spawnError != 0) {
                `qout("Failed to start compiler\n");
                failed = true;
                continue;
            }
            int compilerStatus = 0;
            int waitedPid = waitpid(compilerPid, &compilerStatus, 0);
            if (waitedPid < 0 || (compilerStatus & 0x7F) != 0 || ((compilerStatus |> 8) & 0xFF) != 0) {
                `qout("Failed to compile test\n");
                failed = true;
                continue;
            }
            int testPid = 0;
            char *testArgv[2] = [
                "./a.out",
                nullptr
            ];
            spawnError = posix_spawnp(
                &testPid,
                "./a.out",
                nullptr,
                nullptr,
                testArgv,
                environ
            );
            if (spawnError != 0) {
                `qout("Failed to start test\n");
                failed = true;
                continue;
            }
            int testStatus = 0;
            waitedPid = waitpid(testPid, &testStatus, 0);
            if (waitedPid < 0 || (testStatus & 0x7F) != 0 || ((testStatus |> 8) & 0xFF) != 0) {
                `qout("Test failed\n");
                failed = true;
            }
        }
        if (failed) return 1;
        return 0;
    }
}
}
