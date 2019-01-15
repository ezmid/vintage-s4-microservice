<?php
declare(strict_types=1);
namespace App\Controller;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

/**
 * Api Controller
 */
class ApiController
{
    /**
     * Example route
     *
     * @Route("/")
     * @param Request $request
     * @return JsonResponse
     */
    public function index(Request $request): JsonResponse
    {
        return new JsonResponse([
            'status' => JsonResponse::HTTP_OK
        ]);
    }
}
