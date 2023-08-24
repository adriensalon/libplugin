/*================================================================================================*/
/*
 *
 * Copyright 2023 Avid Technology, Inc.
 * All rights reserved.
 * 
 * CONFIDENTIAL: this document contains confidential information of Avid. Do
 * not disclose to any third party. Use of the information contained in this
 * document is subject to an Avid SDK license.
 *
 */

/**  
 * \file  AAX_IACFTask.h
 *
 * \brief Defines the interface representing an asynchronous task
 *
 */ 
/*================================================================================================*/

#pragma once

#ifndef AAX_IACFTask_H
#define AAX_IACFTask_H

#include "AAX.h"

#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnon-virtual-dtor"
#endif

#include "acfunknown.h"

class AAX_IACFDataBuffer;

/**
 * Completion status for use with \ref AAX_ITask::SetDone()
 * 
 * \ingroup AuxInterface_TaskAgent
 */
enum class AAX_TaskCompletionStatus : int32_t {
	 None = 0
	,Done = 1
	,Canceled = 2
	,Error = 3
};

/** 
 * \brief Versioned interface for an asynchronous task
 *
 * \copydetails AAX_ITask
 * 
 * \ingroup AuxInterface_TaskAgent
 */ 
class AAX_IACFTask : public IACFUnknown
{
public:
	virtual AAX_Result GetType(AAX_CTypeID * oType) const = 0; ///< \copydoc AAX_ITask::GetType()
	virtual AAX_IACFDataBuffer const * GetArgumentOfType(AAX_CTypeID iType) const = 0; ///< \copydoc AAX_ITask::GetArgumentOfType()

	virtual AAX_Result SetProgress(float iProgress) = 0; ///< \copydoc AAX_ITask::SetProgress()
	virtual float GetProgress() const = 0; ///< \copydoc AAX_ITask::GetProgress()

	virtual AAX_Result AddResult(AAX_IACFDataBuffer const * iResult) = 0; ///< \copydoc AAX_ITask::AddResult()

	/**
	 * \brief Inform the host that the task is completed.
	 * 
	 * \details
	 * If \ref AAX_SUCCESS is returned, the object should be
	 * considered invalid and released by the caller.
	 *
	 * \param[in] iStatus
	 * The final status of the task. This indicates to the host
	 * whether or not the task was performed as requested.
	 */
	virtual AAX_Result SetDone(AAX_TaskCompletionStatus iStatus) = 0;
};

#ifdef __clang__
#pragma clang diagnostic pop
#endif

#endif //AAX_IACFTask_H
