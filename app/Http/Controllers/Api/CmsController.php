<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\CmsPage;
use Validator;
use JWTAuth;
use Response;
use JWTFactory;
use Illuminate\Support\Str;
use Tymon\JWTAuth\Exceptions\JWTException;

class CmsController extends Controller
{
    public function postRefreshToken(Request $request) 
    {
        /*$enc = Crypt::e ncrypt('apiuser@harnish.com|123456789');*/
        $inputData = $request->all();

        $header = $request->header('AuthorizationUser');
        if(empty($header))
        {
            $message = 'Authorisation required' ;
            return InvalidResponse($message,101);
        }

        $response = veriftyAPITokenData($header);
        $success = $response->original['success'];
        
        if (!$success) 
        {
            return $response;
        }
    }

    public function cms_page(Request $request)
    {
        $inputData = $request->all();

        $header = $request->header('AuthorizationUser');
        if(empty($header))
        {
            $message = 'Authorisation required' ;
            return InvalidResponse($message,101);
        }

        $response = veriftyAPITokenData($header);
        $success = $response->original['success'];
        
        if (!$success) {
            return $response;
        }

        $page = new CmsPage;
        if(isset($request->slug) && $request->slug != '')
        {
            $slug = $request->slug;
            $page = $page->where('slug','LIKE','%'.$slug.'%');
        }
        $page = $page->first();

        if(!empty($page))
        {
            $message = 'Page Detail';
            return SuccessResponse($message,200,$page);
        } 
        else 
        {
            $message = 'Opps! page not found.';
            return InvalidResponse($message,101);
        }
    }
}
