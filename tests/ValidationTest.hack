use function Facebook\FBExpect\expect;
use namespace HH\Lib\{C, Vec};
use namespace Slack\GraphQL;


final class ValidationTest extends \Facebook\HackTest\HackTest {

    const type TTestCases = dict<string, (string, vec<GraphQL\UserFacingError::TData>)>;

    <<__Override>>
    public static async function beforeFirstTestAsync(): Awaitable<void> {
        await self::runCodegenAsync();
    }

    <<__Memoize>>
    private static async function runCodegenAsync(): Awaitable<void> {
        await GraphQL\Codegen\Generator::forPath(
            __DIR__.'/../src/playground',
            shape(
                'output_directory' => __DIR__.'/gen',
                'namespace' => 'Slack\GraphQL\Test\Generated',
            ),
        );
    }

    <<\Facebook\HackTest\DataProvider('getTestCases')>>
    final public async function test(string $query, vec<string> $expected_errors): Awaitable<void> {
        $source = new \Graphpinator\Source\StringSource($query);
        $parser = new \Graphpinator\Parser\Parser($source);
        $request = $parser->parse();

        $validator = new GraphQL\Validation\Validator(\Slack\GraphQL\Test\Generated\Schema::class);
        $errors = $validator->validate($request);
        expect(Vec\map($errors, $error ==> $error->toShape()))->toEqual($expected_errors);
    }

    public static function getTestCases(): this::TTestCases {
        return dict[

            // Fields On Correct Type Rule

            'FieldsOnCorrectTypeRule: invalid interface field' => tuple(
                'query {
                    viewer {
                        favorite_color
                    }
                }',
                vec[shape(
                    'message' => 'Cannot query field "favorite_color" on type "User".',
                    'location' => shape('line' => 3, 'column' => 25),
                    'path' => vec['viewer'],
                )],
            ),
            'FieldsOnCorrectTypeRule: invalid object fields' => tuple(
                'query {
                    bot(id: 3) {
                        favorite_color
                    }
                    human(id: 3) {
                        primary_function
                    }
                }',
                vec[
                    shape(
                        'message' => 'Cannot query field "favorite_color" on type "Bot".',
                        'location' => shape('line' => 3, 'column' => 25),
                        'path' => vec['bot'],
                    ),
                    shape(
                        'message' => 'Cannot query field "primary_function" on type "Human".',
                        'location' => shape('line' => 6, 'column' => 25),
                        'path' => vec['human'],
                    ),
                ],
            ),
            'FieldsOnCorrectTypeRule: invalid nested object fields' => tuple(
                'query {
                    viewer {
                        team {
                            foo
                        }
                    }
                }',
                vec[shape(
                    'message' => 'Cannot query field "foo" on type "Team".',
                    'location' => shape('line' => 4, 'column' => 29),
                    'path' => vec['viewer', 'team'],
                )],
            ),
            'FieldsOnCorrectTypeRule: valid field' => tuple(
                'query {
                    viewer {
                        name
                    }
                }',
                vec[],
            ),

            // Scalar Leafs Rule

            'ScalarLeafsRule: selection on scalar' => tuple(
                'query {
                    viewer {
                        id {
                            foo
                        }
                    }
                }',
                vec[shape(
                    'message' => 'Field "id" must not have a selection since type "Int" has no subfields.',
                    'location' => shape('line' => 3, 'column' => 25),
                    'path' => vec['viewer', 'id'],
                )],
            ),
            'ScalarLeafsRule: missing selection on nested scalar' => tuple(
                'query {
                    viewer {
                        team {
                            id {
                                foo
                            }
                        }
                    }
                }',
                vec[shape(
                    'message' => 'Field "id" must not have a selection since type "Int" has no subfields.',
                    'location' => shape('line' => 4, 'column' => 29),
                    'path' => vec['viewer', 'team', 'id'],
                )],
            ),
            'ScalarLeafsRule: missing selection on composite' => tuple(
                'query {
                    viewer
                }',
                vec[shape(
                    'message' => 'Field "viewer" of type "User" must have a selection of subfields.',
                    'location' => shape('line' => 2, 'column' => 21),
                    'path' => vec['viewer'],
                )],
            ),
            'ScalarLeafsRule: missing selection on nested composite' => tuple(
                'query {
                    viewer {
                        team
                    }
                }',
                vec[shape(
                    'message' => 'Field "team" of type "Team" must have a selection of subfields.',
                    'location' => shape('line' => 3, 'column' => 25),
                    'path' => vec['viewer', 'team'],
                )],
            ),
            'ScalarLeafsRule: valid selection' => tuple(
                'query {
                    viewer {
                        id
                    }
                }',
                vec[],
            ),
        ];
    }
}
