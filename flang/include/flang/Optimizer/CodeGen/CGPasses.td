//===-- CGPasses.td - code gen pass definition file --------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains definitions for passes within the Optimizer/CodeGen/
//  directory.
//
//===----------------------------------------------------------------------===//

#ifndef FORTRAN_OPTIMIZER_CODEGEN_FIR_PASSES
#define FORTRAN_OPTIMIZER_CODEGEN_FIR_PASSES

include "mlir/Pass/PassBase.td"

def FIRToLLVMLowering : Pass<"fir-to-llvm-ir", "mlir::ModuleOp"> {
  let summary = "Convert FIR dialect to LLVM-IR dialect";
  let description = [{
    Convert the FIR dialect to the LLVM-IR dialect of MLIR. This conversion
    will also convert ops in the standard and FIRCG dialects.
  }];
  let constructor = "::fir::createFIRToLLVMPass()";
  let dependentDialects = [
    "fir::FIROpsDialect", "fir::FIRCodeGenDialect", "mlir::BuiltinDialect",
    "mlir::LLVM::LLVMDialect", "mlir::omp::OpenMPDialect"
  ];
}

def CodeGenRewrite : Pass<"cg-rewrite"> {
  let summary = "Rewrite some FIR ops into their code-gen forms.";
  let description = [{
    Fuse specific subgraphs into single Ops for code generation.
  }];
  let constructor = "fir::createFirCodeGenRewritePass()";
  let dependentDialects = [
    "fir::FIROpsDialect", "fir::FIRCodeGenDialect", "mlir::BuiltinDialect",
    "mlir::LLVM::LLVMDialect", "mlir::omp::OpenMPDialect"
  ];
  let statistics = [
    Statistic<"numDCE", "num-dce'd", "Number of operations eliminated">
  ];
}

#endif // FORTRAN_OPTIMIZER_CODEGEN_FIR_PASSES
