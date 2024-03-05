<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use App\Models\CmsPage;

class CmsController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        $cms_pages = CmsPage::get();
        return view('admin.cms.index',compact('cms_pages'));
    }

    public function create()
    {
        return view('admin.cms.create');
    }

    public function store(Request $request)
    {
        $slug = str_replace(" ","_",$request->title);
        $slug = str_replace("#","_",$slug);
        $slug = str_replace("?","_",$slug);

        $cms_page_create = new CmsPage;
        $cms_page_create->title = $request->title;
        $cms_page_create->slug = strtolower($slug);
        $cms_page_create->short_description = $request->short_description;
        $cms_page_create->description = $request->description;
        $cms_page_create->status = (int) $request->status;
        $cms_page_create->save();

        return redirect()->route('admin.cms.index')->with('success','Page added successfully');
    }

    public function view($id)
    {
        $page = CmsPage::where('_id',$id)->first();
        return view('admin.cms.view',compact('page'));
    }

    public function edit($id)
    {
        $page = CmsPage::where('_id',$id)->first();
        return view('admin.cms.edit',compact('page'));
    }

    public function update(Request $request)
    {
        $slug = str_replace(" ","_",$request->title);
        $slug = str_replace("#","_",$slug);
        $slug = str_replace("?","_",$slug);

        $cms_page_create = CmsPage::where('_id',$request->id)->first();
        $cms_page_create->title = $request->title;
        $cms_page_create->slug = strtolower($slug);
        $cms_page_create->short_description = $request->short_description;
        $cms_page_create->description = $request->description;
        $cms_page_create->status = (int) $request->status;
        $cms_page_create->save();

        return redirect()->route('admin.cms.index')->with('success','Page updated successfully');
    }

    public function delete(Request $request)
    {
        $id = $request->id;
        CmsPage::where('_id',$id)->delete();

        return redirect()->route('admin.cms.index')->with('success','Page deleted successfully');
    }
}
