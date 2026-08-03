; ModuleID = 'master_module'
source_filename = "master_module"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"qsuite::Suite::Settings" = type { %"qsuite::ColorMode", double }
%"qsuite::ColorMode" = type { i32, ptr }
%"qsuite::Suite::Suite" = type { ptr, double }
%"qsuite::Test::Test" = type { ptr }

@stderr = external local_unnamed_addr global ptr, align 8
@.str.43 = private unnamed_addr constant [24 x i8] c"Uncaught exception: %s\0A\00", align 1
@"qsuite::Suite::Suite_vtable" = external constant [0 x ptr]
@.qc.str = private constant [4 x i8] c"int\00"
@.str.41 = private constant [22 x i8] c"Expect throw to throw\00"
@.str.44 = private constant [12 x i8] c"Test QSuite\00"

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #0

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite)
declare noalias ptr @strdup(ptr noundef readonly captures(none)) local_unnamed_addr #2

; Function Attrs: mustprogress nofree nounwind willreturn memory(write, argmem: none, inaccessiblemem: readwrite) uwtable
define internal fastcc noalias noundef ptr @__qc_create_exception(ptr noundef nonnull %0) unnamed_addr #3 {
  %2 = tail call noalias dereferenceable_or_null(48) ptr @malloc(i64 noundef 48) #11
  store i64 5855600185899831380, ptr %2, align 16, !tbaa !5
  %3 = getelementptr inbounds nuw i8, ptr %2, i64 8
  store ptr @_ZL12__qc_cleanup19_Unwind_Reason_CodeP17_Unwind_Exception, ptr %3, align 8, !tbaa !13
  %4 = tail call noalias dereferenceable_or_null(4) ptr @strdup(ptr noundef nonnull @.qc.str) #12
  %5 = getelementptr inbounds nuw i8, ptr %2, i64 32
  store ptr %4, ptr %5, align 16, !tbaa !14
  %6 = getelementptr inbounds nuw i8, ptr %2, i64 40
  store ptr %0, ptr %6, align 8, !tbaa !15
  ret ptr %2
}

; Function Attrs: mustprogress nounwind willreturn uwtable
define internal void @_ZL12__qc_cleanup19_Unwind_Reason_CodeP17_Unwind_Exception(i32 %0, ptr noundef captures(none) %1) #4 {
  %3 = getelementptr inbounds nuw i8, ptr %1, i64 32
  %4 = load ptr, ptr %3, align 16, !tbaa !14
  tail call void @free(ptr noundef %4) #12
  tail call void @free(ptr noundef %1) #12
  ret void
}

; Function Attrs: cold mustprogress noreturn uwtable
define internal fastcc void @__qc_throw(ptr noundef %0) unnamed_addr #5 {
  %2 = tail call i32 @_Unwind_RaiseException(ptr noundef %0)
  %3 = load ptr, ptr @stderr, align 8, !tbaa !16
  %4 = getelementptr inbounds nuw i8, ptr %0, i64 32
  %5 = load ptr, ptr %4, align 16, !tbaa !14
  %6 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %3, ptr noundef nonnull @.str.43, ptr noundef %5) #13
  tail call void @abort() #14
  unreachable
}

declare i32 @_Unwind_RaiseException(ptr noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr noundef captures(none), ptr noundef readonly captures(none), ...) local_unnamed_addr #7

; Function Attrs: cold nofree noreturn nounwind
declare void @abort() local_unnamed_addr #8

declare !qc.return_types !18 void @"qsuite::Suite::Suite_Suite"(ptr, %"qsuite::Suite::Settings") local_unnamed_addr

declare !qc.return_types !19 void @"qsuite::Suite::Suite_operator()"(ptr, ptr, ptr) local_unnamed_addr

declare !qc.return_types !19 void @"qsuite::Test::Test_throws"(ptr, ptr, ptr) local_unnamed_addr

define noundef i32 @__user_entry() local_unnamed_addr !qc.return_types !20 {
entry:
  %enum_int = alloca i32, align 4
  %suite = alloca %"qsuite::Suite::Suite", align 8
  store i32 0, ptr %enum_int, align 4
  %0 = insertvalue %"qsuite::ColorMode" zeroinitializer, ptr %enum_int, 1
  %1 = insertvalue %"qsuite::Suite::Settings" zeroinitializer, %"qsuite::ColorMode" %0, 0
  %2 = insertvalue %"qsuite::Suite::Settings" %1, double 1.000000e+01, 1
  call void @"qsuite::Suite::Suite_Suite"(ptr nonnull %suite, %"qsuite::Suite::Settings" %2)
  store ptr @"qsuite::Suite::Suite_vtable", ptr %suite, align 8
  call void @"qsuite::Suite::Suite_operator()"(ptr nonnull %suite, ptr nonnull @__lambda_0, ptr nonnull @.str.44)
  ret i32 0
}

define void @__lambda_0(%"qsuite::Test::Test" %v) !qc.return_types !19 {
entry:
  %v1 = alloca %"qsuite::Test::Test", align 8
  %v.fca.0.extract = extractvalue %"qsuite::Test::Test" %v, 0
  store ptr %v.fca.0.extract, ptr %v1, align 8
  call void @"qsuite::Test::Test_throws"(ptr nonnull %v1, ptr nonnull @__lambda_1, ptr nonnull @.str.41)
  ret void
}

; Function Attrs: cold noreturn
define void @__lambda_1() #9 !qc.return_types !19 {
entry:
  %0 = alloca i32, align 4
  store i32 1, ptr %0, align 4
  %exception = call fastcc ptr @__qc_create_exception(ptr %0)
  call fastcc void @__qc_throw(ptr %exception)
  unreachable
}

define noundef i32 @main() local_unnamed_addr {
entry:
  %enum_int.i = alloca i32, align 4
  %suite.i = alloca %"qsuite::Suite::Suite", align 8
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %enum_int.i)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %suite.i)
  store i32 0, ptr %enum_int.i, align 4
  %0 = insertvalue %"qsuite::ColorMode" zeroinitializer, ptr %enum_int.i, 1
  %1 = insertvalue %"qsuite::Suite::Settings" zeroinitializer, %"qsuite::ColorMode" %0, 0
  %2 = insertvalue %"qsuite::Suite::Settings" %1, double 1.000000e+01, 1
  call void @"qsuite::Suite::Suite_Suite"(ptr nonnull %suite.i, %"qsuite::Suite::Settings" %2)
  store ptr @"qsuite::Suite::Suite_vtable", ptr %suite.i, align 8
  call void @"qsuite::Suite::Suite_operator()"(ptr nonnull %suite.i, ptr nonnull @__lambda_0, ptr nonnull @.str.44)
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %enum_int.i)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %suite.i)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr captures(none)) #10

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr captures(none)) #10

attributes #0 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nofree nounwind willreturn memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree nounwind willreturn memory(write, argmem: none, inaccessiblemem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nounwind willreturn uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { cold mustprogress noreturn uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { cold nofree noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { cold noreturn }
attributes #10 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nounwind allocsize(0) }
attributes #12 = { nounwind }
attributes #13 = { cold nounwind }
attributes #14 = { cold noreturn nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2, !3, !4}

!0 = !{!"Debian clang version 21.1.8 (7+b1)"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{!6, !8, i64 0}
!6 = !{!"_ZTS14__qc_exception", !7, i64 0, !12, i64 32, !11, i64 40}
!7 = !{!"_ZTS17_Unwind_Exception", !8, i64 0, !11, i64 8, !8, i64 16, !8, i64 24}
!8 = !{!"long", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C++ TBAA"}
!11 = !{!"any pointer", !9, i64 0}
!12 = !{!"p1 omnipotent char", !11, i64 0}
!13 = !{!6, !11, i64 8}
!14 = !{!6, !12, i64 32}
!15 = !{!6, !11, i64 40}
!16 = !{!17, !17, i64 0}
!17 = !{!"p1 _ZTS8_IO_FILE", !11, i64 0}
!18 = !{}
!19 = !{!"void"}
!20 = !{!"int"}
