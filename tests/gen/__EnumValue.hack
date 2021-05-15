/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<a3d1b3a9365ce10125c5cf8935b6610d>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __EnumValue extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__EnumValue';
  const type THackType = \Slack\GraphQL\Introspection\__EnumValue;
  const keyset<string> FIELD_NAMES = keyset[
    'deprecationReason',
    'description',
    'isDeprecated',
    'name',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'deprecationReason':
        return new GraphQL\FieldDefinition(
          'deprecationReason',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getDeprecationReason(),
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getDescription(),
        );
      case 'isDeprecated':
        return new GraphQL\FieldDefinition(
          'isDeprecated',
          Types\BooleanOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->isDeprecated(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      default:
        return null;
    }
  }
}
