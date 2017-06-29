//Thoth Gunter
//This 
#include "PLTEvent.h"
#include "PLTU.h"
#include "PLTBinaryFileReader.h"
#include <pybind11/pybind11.h>



enum SelectionFilter{
  effeciencyFilter,
  zeroCountingFilter,
  accidentalFilter,
  noFilter
};

struct SlinkDataFrame
{

  SlinkDataFrame();

  SlinkDataFrame(std::string const DataFileName, std::string const GainCalFileName, std::string const AlignmentFileName, std::string const MaskFileName = "Mask_2016_VdM_v1.txt")
  {

    Event = Event(DataFileName, GainCalFileName, AlignmentFileName);
    Event.ReadOnlinePixelMask(MaskFileName);
    Event.SetPlaneFiducialRegion(FidRegionHits);
    Event.SetPlaneClustering(PLTPlane::kClustering_AllTouching,PLTPlane::kFiducialRegion_All);

    Alignment.ReadAlignmentFile(AlignmentFileName);  
  }

  ~SlinkDataFrame();



  void LoadEvents( int events, SelectionFilter filter = SelectionFilter::effeciencyFilter)
  {

    //We loop over every event in the DataFile. 
    //We apply filters that constrain the events that pass.
    //These filter currently derive from the effeciency, accidental and zero counting analyses. 
    //
    //Are there cleverer storage methods.
    for (int ientry = 0; Event.GetNextEvent() >= 0; ++ientry)
    {

      for (size_t it = 0; it != Event.NTelescopes(); ++it){
        PLTTelescope* Telescope = Event.Telescope(it);


        //FILTERS
        switch(filter)
        {
          case SelectionFilter::effeciencyFilter :
          {
            if (Telescope->NHitPlanes() < 2 || (unsigned)(Telescope->NHitPlanes()) != Telescope->NClusters()) continue;
          }
          case SelectionFilter::zeroCountingFilter :
          case SelectionFilter::accidentalFilter:
          case SelectionFilter::noFilter:
          break;

        }


        int const channel = Telescope->Channel();
        for( int plane = 0; plane != Telescope->NPlanes(); plane++ ){

          //Push data 
          if ( (Telescope->Plane(ip))->NClusters() == 0) continue;
          pos_dict[Event.Time()][channel][plane].push_back(((Telescope->Plane(ip))->Cluster(0)).LCenterOfMass());//Stores local charge center. We might want to use come thing else.

        }

      
      if(ientry == events) break;
      if(ientry == 100 * 5000) break;//Corresponds to ~ 1.5 Gbs if every channel and every plane gets a hit.  
    } 
  }


  //members
  PLTEvent Event;
  PLTAlignment Alignment;

  //Data frame set-up
  //time, channel, plane, local position
  std::map<uint32_t, std::map<int, std::map<int, std::vector<std::pair<float,float> >>>> pos_dict;
  
}


//
//Python Bindings
namespace py = pybind11;

PYBIND11_PLUGIN(libLoad_File)
{
  using namespace py;

  py::module m("libLoad_File", "python load_file bindings");
  py::class_<SlinkDataFrame>(m, "SlinkDataFrame")
    .def(py::init<>())
  ;
  
  return m.ptr();
}




