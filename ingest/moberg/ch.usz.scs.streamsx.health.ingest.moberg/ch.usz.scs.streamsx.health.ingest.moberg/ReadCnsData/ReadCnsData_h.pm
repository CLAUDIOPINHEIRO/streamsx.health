
package ReadCnsData_h;
use strict; use Cwd 'realpath';  use File::Basename;  use lib dirname(__FILE__);  use SPL::Operator::Instance::OperatorInstance; use SPL::Operator::Instance::Annotation; use SPL::Operator::Instance::Context; use SPL::Operator::Instance::Expression; use SPL::Operator::Instance::ExpressionTree; use SPL::Operator::Instance::ExpressionTreeEvaluator; use SPL::Operator::Instance::ExpressionTreeVisitor; use SPL::Operator::Instance::ExpressionTreeCppGenVisitor; use SPL::Operator::Instance::InputAttribute; use SPL::Operator::Instance::InputPort; use SPL::Operator::Instance::OutputAttribute; use SPL::Operator::Instance::OutputPort; use SPL::Operator::Instance::Parameter; use SPL::Operator::Instance::StateVariable; use SPL::Operator::Instance::TupleValue; use SPL::Operator::Instance::Window; 
sub main::generate($$) {
   my ($xml, $signature) = @_;  
   print "// $$signature\n";
   my $model = SPL::Operator::Instance::OperatorInstance->new($$xml);
   unshift @INC, dirname ($model->getContext()->getOperatorDirectory()) . "/../impl/nl/include";
   $SPL::CodeGenHelper::verboseMode = $model->getContext()->isVerboseModeOn();
   print '/* Additional includes go here */', "\n";
   print 'namespace CNSDataAccess', "\n";
   print '{', "\n";
   print '	class DataAccess;', "\n";
   print '	class CPayload;', "\n";
   print '	class CAspects;', "\n";
   print '}', "\n";
   print "\n";
   print 'namespace CNSDataAccessWrapper', "\n";
   print '{', "\n";
   print '	class IcuDataAccess;', "\n";
   print '	class DataSettingsFile;', "\n";
   print '	class IcuDataSource;', "\n";
   print '}', "\n";
   print "\n";
   SPL::CodeGen::headerPrologue($model);
   print "\n";
   print "\n";
   print '#define PLATFORM_LINUX', "\n";
   print '#include "icu/cns/mrtypes.h"  // ClockTime typedef', "\n";
   print "\n";
   print 'typedef struct {', "\n";
   print '	CNSDataAccessWrapper::IcuDataAccess* dataAccess;', "\n";
   print '	std::string patientId;', "\n";
   print '	std::string medicalRecordNumber;', "\n";
   print "\n";
   print '} ProcessingContext;', "\n";
   print "\n";
   print "\n";
   print 'class MY_OPERATOR : public MY_BASE_OPERATOR ', "\n";
   print '{', "\n";
   print 'public:', "\n";
   print '	', "\n";
   print '  // Constructor', "\n";
   print '  MY_OPERATOR();', "\n";
   print "\n";
   print '  // Destructor', "\n";
   print '  virtual ~MY_OPERATOR(); ', "\n";
   print "\n";
   print '  // Notify port readiness', "\n";
   print '  void allPortsReady(); ', "\n";
   print "\n";
   print '  // Notify pending shutdown', "\n";
   print '  void prepareToShutdown(); ', "\n";
   print "\n";
   print '  // Processing for source and threaded operators   ', "\n";
   print '  void process(uint32_t idx);', "\n";
   print "\n";
   print '  // Tuple processing for non-mutating ports', "\n";
   print '  void process(Tuple const & tuple, uint32_t port);', "\n";
   print '  ', "\n";
   print '  ', "\n";
   print '  ', "\n";
   print '  ', "\n";
   print '  ', "\n";
   print 'private:', "\n";
   print '    ', "\n";
   print '  void processAspectHistoricAndLive(CNSDataAccess::CAspects& aspect, CNSDataAccessWrapper::IcuDataSource* cns_source);', "\n";
   print '  ', "\n";
   print '  // to use this method you need to make a change in the CNS Data Access library', "\n";
   print '  void processAspectLiveOnly(CNSDataAccess::CAspects& aspect, CNSDataAccessWrapper::IcuDataSource* cns_source);', "\n";
   print '  ', "\n";
   print '  // can not be const because payload.GetMessagesAt() is not const. ', "\n";
   print '  void processMeasurements(', "\n";
   print '		  	CNSDataAccessWrapper::DataSettingsFile& dataSettingsFile,', "\n";
   print '		  	CNSDataAccess::CPayload& payload,  ', "\n";
   print '		    const ClockTime timestamp,', "\n";
   print '		    const std::string units,', "\n";
   print '			const size_t& i,', "\n";
   print '			const float& m, const float& b);', "\n";
   print '  ', "\n";
   print "\n";
   print '  void processCompositeMeasurements(', "\n";
   print '  		CNSDataAccessWrapper::DataSettingsFile& dataSettingsFile,', "\n";
   print '  		CNSDataAccess::CPayload& payload, ', "\n";
   print '		const std::string& mrn, ', "\n";
   print '		const std::string& aspect, ', "\n";
   print '		const std::string& correctedTimestamp,', "\n";
   print '  	    const std::string units,', "\n";
   print '  		const size_t& i,', "\n";
   print '  		const float& m, const float& b);', "\n";
   print '  ', "\n";
   print '  ', "\n";
   print '  /*', "\n";
   print '   * Currently not used by ICU. this methods may be used for the IBM health toolkit', "\n";
   print '   * Need to be tested with the new method. ReviewLatest()', "\n";
   print '   * ', "\n";
   print '   * can not be const because payload.GetMessagesAt() is not const. ', "\n";
   print '   */', "\n";
   print '  void setEventTuple(', "\n";
   print '		  CNSDataAccess::CPayload& payload, ', "\n";
   print '		  const size_t& i,', "\n";
   print '		  OPort1Type& tuple) const;', "\n";
   print '  ', "\n";
   print '  void sendMeasurementTuple(', "\n";
   print '		  const std::string& mrn, ', "\n";
   print '		  const std::string& aspect,', "\n";
   print '		  const std::string& timestamp,', "\n";
   print '		  const std::string& unit,', "\n";
   print '		  const float& value);', "\n";
   print '  ', "\n";
   print '  void sendMeasurementTupleInt(', "\n";
   print '		  const std::string& mrn, ', "\n";
   print '		  const std::string& aspect,', "\n";
   print '		  const std::string& timestamp,', "\n";
   print '		  const std::string& unit,', "\n";
   print '		  const int& value);', "\n";
   print '  ', "\n";
   print '  /*', "\n";
   print '    * Currently not used by ICU. this methods may be used for the IBM health toolkit', "\n";
   print '    * Need to be tested with the new method. ReviewLatest()', "\n";
   print '    * ', "\n";
   print '    * can not be const because payload.GetMessagesAt() is not const. ', "\n";
   print '    */', "\n";
   print '  void submitEventTuples(CNSDataAccess::CPayload& payload);', "\n";
   print '  ', "\n";
   print '  // can not be const because payload.GetMessagesAt() is not const. ', "\n";
   print '  void submitDataTuples(', "\n";
   print '		  CNSDataAccessWrapper::IcuDataSource* cns_source, ', "\n";
   print '		  CNSDataAccess::CPayload& payload,', "\n";
   print '		  const float64 m, const float64 b);', "\n";
   print '  ', "\n";
   print '  ', "\n";
   print '  float32 convertSampleSeriesValue(const float32 &value, const float64& m, const float64& b) const;', "\n";
   print '  int32 convertSampleSeriesValueInt(const int32 &value, const float64& m, const float64& b) const;', "\n";
   print '  std::string convertTimestamp(const int64 timestamp) const;  ', "\n";
   print '  int getFirstCompositeElementsValueType(const std::string& firstElement) const;', "\n";
   print "\n";
   print '  void switchPatientIfNeeded();', "\n";
   print '  void prepareNextPatient(const std::string& pid, const std::string& mrn); // TODO: delete', "\n";
   print '  ', "\n";
   print '  void handleStartTime(const ClockTime start_time);', "\n";
   print '  void handlePatient(const std::string& next_pid, const std::string& next_mrn, const bool next_is_valid);', "\n";
   print '  void openPatientDirectory(const std::string& pid, const std::string& mrn);', "\n";
   print '  void createNextContext(const std::string& pid, const std::string& mrn);', "\n";
   print '  void deleteNextContext();', "\n";
   print '  ', "\n";
   print '  bool getCurrentPatientIsValid();', "\n";
   print '  std::string getCurrentMrn();', "\n";
   print '  std::string getCurrentPid();', "\n";
   print '  std::vector <CNSDataAccess::CAspects> getCurrentAspects();', "\n";
   print '  ClockTime getCurrentTime();', "\n";
   print "\n";
   print '  float64 updateSampleConversionsSlopeParam(CNSDataAccessWrapper::IcuDataSource* cns_source, const std::string& type) const;', "\n";
   print '  float64 updateSampleConversionYInterceptParam(CNSDataAccessWrapper::IcuDataSource* cns_source, const std::string& type) const;', "\n";
   print "\n";
   print '  bool isTimestampOutOfBound(const ClockTime& start_time);', "\n";
   print '  bool isTimestampOutOfBound(const ClockTime& start_time, const ClockTime& current_time);', "\n";
   print "\n";
   print '  std::string cns_archive_;', "\n";
   print '  int cns_sleep_ms_;', "\n";
   print '  ClockTime cns_payload_duration_usec_; ', "\n";
   print '  ', "\n";
   print '  ProcessingContext* current_context_;', "\n";
   print '  ProcessingContext* next_context_;', "\n";
   print '  bool context_change_needed_;', "\n";
   print '  bool current_is_valid_;', "\n";
   print '  bool next_is_valid_;', "\n";
   print "\n";
   print '  // Mutex protecting data in next_context_ Context and the context switch.', "\n";
   print '  // Data in current_context_ need not be protected, because only the process loop accesses it (and does the context switch)', "\n";
   print '  Mutex context_mutex_; ', "\n";
   print '  ', "\n";
   print '  ClockTime current_start_time_;', "\n";
   print '  ClockTime next_start_time_;', "\n";
   print "\n";
   print '}; ', "\n";
   print "\n";
   SPL::CodeGen::headerEpilogue($model);
   print "\n";
   print "\n";
   print "\n";
   CORE::exit $SPL::CodeGen::USER_ERROR if ($SPL::CodeGen::sawError);
}
1;